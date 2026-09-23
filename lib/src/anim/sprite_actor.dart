import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:eyehelper/src/anim/sprite_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// What to draw on a given frame.
class SpritePose {
  final SpriteAnimation animation;
  final double time;

  const SpritePose(this.animation, this.time);
}

/// Drives a [SpriteActor] by hand instead of letting it loop its own
/// animation — the training flow uses this to count repetitions and fire
/// cues at exact moments.
abstract class SpriteController {
  /// Called once the sheet is attached, and again if the actor is rebuilt
  /// with a different controller.
  void initialize(SpriteSheet sheet) {}

  /// Called every unpaused frame with the seconds since the last one. Return
  /// the pose to draw, or null to keep the previous frame.
  SpritePose? advance(double elapsed);
}

/// Plays a sprite-sheet animation, fitted `contain` and centred like the
/// Flare actor it replaces.
class SpriteActor extends StatefulWidget {
  final SpriteSheet sheet;

  /// Looped when there is no [controller].
  final String animation;
  final bool isPaused;
  final SpriteController? controller;

  const SpriteActor({
    super.key,
    required this.sheet,
    required this.animation,
    this.isPaused = false,
    this.controller,
  });

  @override
  State<SpriteActor> createState() => _SpriteActorState();
}

class _SpriteActorState extends State<SpriteActor> with SingleTickerProviderStateMixin {
  // Atlases are shared between every actor showing the same face and live
  // for the whole session, like the image cache would keep them anyway.
  static final Map<String, Future<ui.Image>> _atlases = {};

  static Future<ui.Image> _loadAtlas(String asset) {
    return _atlases.putIfAbsent(asset, () async {
      final bytes = await rootBundle.load(asset);
      final codec = await ui.instantiateImageCodec(bytes.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      codec.dispose();
      return frame.image;
    });
  }

  late final Ticker _ticker = createTicker(_tick);
  final ValueNotifier<SpritePose?> _pose = ValueNotifier(null);
  ui.Image? _atlas;
  Duration? _lastTick;
  double _time = 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.initialize(widget.sheet);
    // Flare applied the animation the moment it loaded; without this the
    // first frame would show the layers at their unanimated defaults.
    if (widget.controller == null) {
      final animation = widget.sheet.animation(widget.animation);
      if (animation != null) {
        _pose.value = SpritePose(animation, 0);
      }
    }
    _loadAtlas(widget.sheet.atlas).then((image) {
      if (mounted) {
        setState(() => _atlas = image);
      }
    });
    _ticker.start();
  }

  @override
  void didUpdateWidget(SpriteActor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller || widget.sheet != oldWidget.sheet) {
      widget.controller?.initialize(widget.sheet);
    }
    if (widget.animation != oldWidget.animation) {
      _time = 0;
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _pose.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    final last = _lastTick;
    _lastTick = elapsed;
    if (last == null || widget.isPaused) {
      return;
    }
    final dt = (elapsed - last).inMicroseconds / Duration.microsecondsPerSecond;

    final controller = widget.controller;
    if (controller != null) {
      final pose = controller.advance(dt);
      if (pose != null) {
        _pose.value = pose;
      }
      return;
    }

    final animation = widget.sheet.animation(widget.animation);
    if (animation == null) {
      return;
    }
    _time += dt;
    _pose.value = SpritePose(animation, _time % animation.duration);
  }

  @override
  Widget build(BuildContext context) {
    final atlas = _atlas;
    if (atlas == null) {
      return const SizedBox.expand();
    }
    return CustomPaint(
      painter: _SpritePainter(sheet: widget.sheet, atlas: atlas, pose: _pose),
      size: Size.infinite,
    );
  }
}

class _SpritePainter extends CustomPainter {
  final SpriteSheet sheet;
  final ui.Image atlas;
  final ValueListenable<SpritePose?> pose;

  _SpritePainter({required this.sheet, required this.atlas, required this.pose})
      : super(repaint: pose);

  @override
  void paint(Canvas canvas, Size size) {
    final board = sheet.artboard;
    final fit = math.min(size.width / board.width, size.height / board.height);
    canvas.save();
    canvas.translate((size.width - board.width * fit) / 2, (size.height - board.height * fit) / 2);
    canvas.scale(fit);

    // Animated values start from the layer's own defaults.
    final translations = [for (final l in sheet.layers) l.translation];
    final opacities = [for (final l in sheet.layers) l.opacity];
    final current = pose.value;
    if (current != null) {
      for (final track in current.animation.tracks) {
        final value = track.valueAt(current.time);
        switch (track.prop) {
          case SpriteProp.posX:
            translations[track.layer] = Offset(value, translations[track.layer].dy);
          case SpriteProp.posY:
            translations[track.layer] = Offset(translations[track.layer].dx, value);
          case SpriteProp.opacity:
            opacities[track.layer] = value;
        }
      }
    }

    // World transform: parents contribute their translation, scale and
    // opacity, the way Flare composes its node tree.
    final worldTranslation = List<Offset>.filled(sheet.layers.length, Offset.zero);
    final worldScale = List<double>.filled(sheet.layers.length, 1);
    final worldOpacity = List<double>.filled(sheet.layers.length, 1);
    for (var i = 0; i < sheet.layers.length; i++) {
      final parent = sheet.layers[i].parent;
      if (parent == null) {
        worldTranslation[i] = translations[i];
        worldScale[i] = sheet.layers[i].scale;
        worldOpacity[i] = opacities[i];
      } else {
        worldTranslation[i] = worldTranslation[parent] + translations[i] * worldScale[parent];
        worldScale[i] = worldScale[parent] * sheet.layers[i].scale;
        worldOpacity[i] = worldOpacity[parent] * opacities[i];
      }
    }

    final order = List<int>.generate(sheet.layers.length, (i) => i)
      ..sort((a, b) => sheet.layers[a].drawOrder.compareTo(sheet.layers[b].drawOrder));

    Rect dstOf(int i, SpriteImageLayer layer) {
      final t = worldTranslation[i];
      final s = worldScale[i];
      return Rect.fromLTRB(
        t.dx + layer.local.left * s,
        t.dy + layer.local.top * s,
        t.dx + layer.local.right * s,
        t.dy + layer.local.bottom * s,
      );
    }

    // The sprites were drawn on opaque white squares, and the scenes lean on
    // that: a "closed eyes" frame painted over the "open eyes" frame, hands
    // fading in over the face. The white is gone from the atlases so the
    // faces sit on the app background, so the covering has to be reproduced
    // here: whatever an image drawn later entirely covers shows through only
    // by the part of that image that is still transparent. At full opacity
    // the layer underneath is hidden; mid-fade it dims as the top fades in —
    // the same crossfade the white backdrop used to give.
    final dsts = <int, Rect>{};
    for (final i in order) {
      final layer = sheet.layers[i];
      if (layer is SpriteImageLayer && worldOpacity[i] > 0) {
        dsts[i] = dstOf(i, layer);
      }
    }
    double showThrough(int i, Rect rect) {
      var factor = 1.0;
      for (var k = order.indexOf(i) + 1; k < order.length; k++) {
        final j = order[k];
        final above = dsts[j];
        if (above != null && _contains(above, rect)) {
          factor *= 1 - worldOpacity[j].clamp(0.0, 1.0);
        }
      }
      return factor;
    }

    for (final i in order) {
      final layer = sheet.layers[i];
      var opacity = worldOpacity[i].clamp(0.0, 1.0);
      if (opacity <= 0) {
        continue;
      }
      final t = worldTranslation[i];
      final s = worldScale[i];

      if (layer is SpriteImageLayer) {
        final dst = dsts[i]!;
        opacity *= showThrough(i, dst);
        if (opacity <= 0.002) {
          continue;
        }
        canvas.drawImageRect(
          atlas,
          layer.src,
          dst,
          Paint()
            ..color = Color.fromRGBO(255, 255, 255, opacity)
            ..filterQuality = FilterQuality.medium,
        );
      } else if (layer is SpriteRectLayer) {
        final rect = Rect.fromCenter(
          center: t,
          width: layer.size.width * s,
          height: layer.size.height * s,
        );
        opacity *= showThrough(i, rect);
        if (opacity <= 0.002) {
          continue;
        }
        canvas.drawRect(rect, Paint()..color = layer.color.withValues(alpha: opacity));
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_SpritePainter oldDelegate) =>
      oldDelegate.sheet != sheet || oldDelegate.atlas != atlas || oldDelegate.pose != pose;
}

/// [outer] contains [inner], allowing for a pixel of float noise.
bool _contains(Rect outer, Rect inner) {
  const eps = 1.0;
  return outer.left <= inner.left + eps &&
      outer.top <= inner.top + eps &&
      outer.right >= inner.right - eps &&
      outer.bottom >= inner.bottom - eps;
}
