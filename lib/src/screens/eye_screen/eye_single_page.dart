import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/anim/sprite_actor.dart';
import 'package:eyehelper/src/anim/sprite_sheet.dart';
import 'package:eyehelper/src/helpers/format_duration.dart';
import 'package:eyehelper/src/helpers/preferences.dart';
import 'package:eyehelper/src/models/swiper_screen_info.dart';
import 'package:eyehelper/src/screens/eye_screen/training_controls.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/animated_face.dart';
import 'package:eyehelper/src/widgets/app_bar_blur.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:vibration/vibration.dart';

enum _Phase { idle, countdown, training }

/// One exercise card: title and instruction on top, the face in a ring in
/// the middle, Start or the training controls at the bottom.
class EyeSinglePage extends StatefulWidget {
  final SwiperScreenInfo info;
  final SwiperController controller;
  final Function startBtnCallback;
  final Function finishBtnCallback;

  /// Debug builds only: jump straight to the finish screen, which otherwise
  /// shows up once a day.
  final VoidCallback? debugShowFinish;

  const EyeSinglePage({
    super.key,
    required this.info,
    required this.controller,
    required this.startBtnCallback,
    required this.finishBtnCallback,
    this.debugShowFinish,
  });

  @override
  State<EyeSinglePage> createState() => _EyeSinglePageState();
}

class _EyeSinglePageState extends State<EyeSinglePage>
    with TickerProviderStateMixin
    implements SpriteController {
  /// 160 pt before the redesign; ten percent more and not a point beyond.
  static const double _faceSize = 176;
  static const double _stageSize = 224;
  static const double _ringStroke = 5;
  static const int _countdownSeconds = 3;

  _Phase _phase = _Phase.idle;
  bool _paused = false;

  /// Blinking runs 25 reps of a third of a second — counting those one by one
  /// is noise. Anything that quick gets one ring and one countdown for the
  /// whole set instead of per repetition.
  bool get _continuous => widget.info.duration < 2;
  Duration get _setLength =>
      Duration(milliseconds: (widget.info.duration * widget.info.times * 1000).round());

  SpriteAnimation? _face;
  double _faceTime = 0.0;
  int _counter = 0;
  Timer? _counterTimer;
  String _cue = '';

  /// Share of the current repetition done — drives the ring without
  /// rebuilding the page every frame.
  final ValueNotifier<double> _progress = ValueNotifier(0);

  /// Pulls the veil over the face the moment Start is pressed…
  late final AnimationController _cover = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  /// …and the countdown lifts it again, evenly, over three seconds.
  late final AnimationController _countdown = AnimationController(
    vsync: this,
    duration: const Duration(seconds: _countdownSeconds),
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _beginTraining();
      }
    });

  @override
  void dispose() {
    _counterTimer?.cancel();
    _cover.dispose();
    _countdown.dispose();
    _progress.dispose();
    super.dispose();
  }

  void _start() {
    setState(() {
      _phase = _Phase.countdown;
      _paused = false;
      _cue = '';
    });
    widget.startBtnCallback();
    _countdown.value = 0;
    _cover.forward(from: 0).then((_) {
      if (mounted && _phase == _Phase.countdown) {
        _countdown.forward(from: 0);
      }
    });
  }

  void _beginTraining() {
    if (!mounted) {
      return;
    }
    _faceTime = 0;
    _counter = 0;
    setState(() => _phase = _Phase.training);
  }

  void _finish() {
    _countdown.stop();
    _cover.value = 0;
    _counter = 0;
    _progress.value = 0;
    setState(() {
      _phase = _Phase.idle;
      _paused = false;
      _cue = '';
    });
    widget.finishBtnCallback();
  }

  // ---- SpriteController -------------------------------------------------

  @override
  void initialize(SpriteSheet sheet) {
    _face = sheet.animation(widget.info.trainingAnimationName);
  }

  @override
  SpritePose? advance(double elapsed) {
    final face = _face;
    if (face == null) {
      return null;
    }
    _faceTime += elapsed;
    final relativeTime = _faceTime % face.duration;
    _progress.value = _continuous
        ? ((_counter + relativeTime / face.duration) / widget.info.times).clamp(0.0, 1.0)
        : relativeTime / face.duration;

    final info = widget.info;
    if (info.firstTextTime < relativeTime + 0.05 && info.firstTextTime > relativeTime - 0.05) {
      _showCue(trKey(context, info.trainingFirstText));
    }
    if (info.secondTextTime < relativeTime + 0.05 && info.secondTextTime > relativeTime - 0.05) {
      _showCue(trKey(context, info.trainingSecondText));
    }

    if (relativeTime >= info.duration - 0.02 && _counterTimer == null) {
      _counterTimer = Timer(const Duration(milliseconds: 300), () {
        _counterTimer?.cancel();
        _counterTimer = null;
      });
      _counter += 1;
      if (_counter >= info.times) {
        _finish();
      } else {
        setState(() {});
      }
    }
    return SpritePose(face, relativeTime);
  }

  void _showCue(String text) {
    if (text != _cue) {
      setState(() => _cue = text);
      if (FastPreferences().prefs.getBool(FastPreferences.isVibrationEnabled) ?? true) {
        Vibration.vibrate();
      }
    }
  }

  // ---- UI ---------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final info = widget.info;
    final safe = MediaQuery.paddingOf(context);
    final training = _phase == _Phase.training;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, safe.top + kGlassAppBarHeight + 16, 24, safe.bottom + 100),
      child: Column(
        children: [
          Text(
            trKey(context, info.title),
            textAlign: TextAlign.center,
            style: appText(21, weight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          // Nobody reads the instruction mid-exercise; let it step back.
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: training ? 0.55 : 1,
            child: Text(
              trKey(context, info.mainText),
              textAlign: TextAlign.center,
              style: appText(14, color: EyehelperColorScheme.mainDark, height: 1.4),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 28,
            child: _phase == _Phase.idle
                ? _MetaPill(
                    '${t.exercises.reps(n: info.times)} · ${formatDuration(context, _setLength)}',
                  )
                : null,
          ),
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _buildStage(),
              ),
            ),
          ),
          SizedBox(
            height: 24,
            child: Text(
              _phase == _Phase.countdown ? t.training.getReady : _cue.replaceAll('\n', ' '),
              textAlign: TextAlign.center,
              style: appText(
                17,
                weight: _phase == _Phase.countdown ? FontWeight.normal : FontWeight.w600,
                color: _phase == _Phase.countdown ? EyehelperColorScheme.lightGrey : appAccentDeep,
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (_phase == _Phase.idle)
            RoundCustomButton(
              parentSize: MediaQuery.of(context).size,
              onPressed: _start,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(t.exercises.beginButton, style: Theme.of(context).textTheme.labelLarge),
              ),
            )
          else
            TrainingControls(
              paused: _paused,
              canPause: training,
              reps: _continuous
                  ? formatDuration(context, _setLength - Duration(seconds: (_faceTime).floor()))
                  : t.exercises.repsOf(done: math.min(_counter + 1, info.times), total: info.times),
              onPauseResume: () => setState(() => _paused = !_paused),
              onStop: _finish,
            ),
          if (kDebugMode && _phase == _Phase.idle && widget.debugShowFinish != null)
            TextButton(
              onPressed: widget.debugShowFinish,
              child: Text(
                'Показать финальный экран (debug)',
                style: appText(12, color: EyehelperColorScheme.lightGrey),
              ),
            ),
        ],
      ),
    );
  }

  /// Ring, face, and the countdown veil on top of the face.
  Widget _buildStage() {
    return SizedBox(
      width: _stageSize,
      height: _stageSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // The ring only means something while a repetition is running; it
          // fades in with the training and out when it ends.
          AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _phase == _Phase.training ? 1 : 0,
            child: CustomPaint(
              size: const Size.square(_stageSize),
              painter: _RingPainter(progress: _progress, stroke: _ringStroke),
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_cover, _countdown]),
            builder: (context, child) {
              // Fully veiled right after Start, then clearing as the count
              // runs down; zero outside the countdown.
              final veil = _phase == _Phase.countdown ? _cover.value * (1 - _countdown.value) : 0.0;
              final secondsLeft = _countdownSeconds - (_countdown.value * _countdownSeconds).floor();
              return Stack(
                alignment: Alignment.center,
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 10 * veil, sigmaY: 10 * veil),
                    child: Opacity(opacity: 1 - 0.75 * veil, child: child),
                  ),
                  if (veil > 0)
                    Opacity(
                      opacity: veil,
                      child: Text(
                        '${secondsLeft.clamp(1, _countdownSeconds)}',
                        style: appText(64, weight: FontWeight.w200, height: 1),
                      ),
                    ),
                ],
              );
            },
            child: AnimatedFace(
              info: widget.info,
              size: _faceSize,
              isPaused: _paused,
              controller: _phase == _Phase.training ? this : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  final String text;

  const _MetaPill(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F1E9),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: appText(12.5, weight: FontWeight.w600, color: appAccentDeep)),
    );
  }
}

/// Track plus an arc that fills clockwise from the top over one repetition.
class _RingPainter extends CustomPainter {
  final ValueListenable<double> progress;
  final double stroke;

  _RingPainter({required this.progress, required this.stroke}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2);
    canvas.drawArc(
      arc,
      0,
      math.pi * 2,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = const Color(0xFFE3F1E9),
    );
    final value = progress.value.clamp(0.0, 1.0);
    if (value > 0) {
      canvas.drawArc(
        arc,
        -math.pi / 2,
        math.pi * 2 * value,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.round
          ..color = EyehelperColorScheme.activeColor,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.stroke != stroke;
}
