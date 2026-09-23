import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Pause and stop as glass buttons, with the repetition count between them.
/// Same width as the Start button it replaces, so nothing jumps.
class TrainingControls extends StatelessWidget {
  final bool paused;

  /// False during the countdown, when there is nothing to pause yet.
  final bool canPause;
  final String reps;
  final VoidCallback onPauseResume;
  final VoidCallback onStop;

  const TrainingControls({
    super.key,
    required this.paused,
    required this.canPause,
    required this.reps,
    required this.onPauseResume,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 50,
      child: Row(
        children: [
          Opacity(
            opacity: canPause ? 1 : 0.4,
            child: GlassIconButton(
              size: 44,
              icon: Icon(
                paused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                color: appAccentDeep,
              ),
              onPressed: canPause ? onPauseResume : () {},
            ),
          ),
          Expanded(
            child: Center(
              child: Text(reps, style: appText(15, weight: FontWeight.w600)),
            ),
          ),
          GlassIconButton(
            size: 44,
            icon: const Icon(Icons.stop_rounded, color: appAccentDeep),
            onPressed: onStop,
          ),
        ],
      ),
    );
  }
}
