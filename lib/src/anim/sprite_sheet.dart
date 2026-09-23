import 'dart:ui';

/// Which property a track animates. Only what the exercise faces ever keyed.
enum SpriteProp { posX, posY, opacity }

class SpriteKey {
  final double time;
  final double value;

  /// Step to the next key instead of interpolating — Flare's "hold".
  final bool hold;

  const SpriteKey(this.time, this.value, {this.hold = false});
}

class SpriteTrack {
  final int layer;
  final SpriteProp prop;
  final List<SpriteKey> keys;

  const SpriteTrack(this.layer, this.prop, this.keys);

  /// Value at [time]; clamps to the first/last key outside the keyed range.
  double valueAt(double time) {
    if (keys.isEmpty) {
      return 0;
    }
    if (time <= keys.first.time) {
      return keys.first.value;
    }
    for (var i = 0; i < keys.length - 1; i++) {
      final a = keys[i];
      final b = keys[i + 1];
      if (time < b.time) {
        if (a.hold || b.time == a.time) {
          return a.value;
        }
        final t = (time - a.time) / (b.time - a.time);
        return a.value + (b.value - a.value) * t;
      }
    }
    return keys.last.value;
  }
}

class SpriteAnimation {
  final String name;

  /// Seconds; the animation loops over this.
  final double duration;
  final List<SpriteTrack> tracks;

  const SpriteAnimation(this.name, this.duration, this.tracks);
}

/// A node of the artboard. Transforms are translation plus uniform scale —
/// nothing in the faces rotates.
abstract class SpriteLayer {
  final int? parent;
  final Offset translation;
  final double scale;
  final double opacity;
  final int drawOrder;

  const SpriteLayer({
    required this.parent,
    required this.translation,
    required this.scale,
    required this.opacity,
    required this.drawOrder,
  });
}

/// A region of the atlas drawn into [local] artboard coordinates.
class SpriteImageLayer extends SpriteLayer {
  final Rect src;
  final Rect local;

  const SpriteImageLayer({
    required super.parent,
    required super.translation,
    required super.scale,
    required super.opacity,
    required super.drawOrder,
    required this.src,
    required this.local,
  });
}

/// A solid rectangle centred on its translation.
class SpriteRectLayer extends SpriteLayer {
  final Size size;
  final Color color;

  const SpriteRectLayer({
    required super.parent,
    required super.translation,
    required super.scale,
    required super.opacity,
    required super.drawOrder,
    required this.size,
    required this.color,
  });
}

class SpriteSheet {
  final String atlas;
  final Size artboard;
  final List<SpriteLayer> layers;
  final List<SpriteAnimation> animations;

  const SpriteSheet({
    required this.atlas,
    required this.artboard,
    required this.layers,
    required this.animations,
  });

  SpriteAnimation? animation(String name) {
    for (final a in animations) {
      if (a.name == name) {
        return a;
      }
    }
    return null;
  }
}
