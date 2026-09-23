import 'package:eyehelper/src/screens/notification_screen/dtos/time_formatter.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:flutter/material.dart';

/// The working window as a bar with a dot per reminder. Dots already behind
/// [now] are dark and ticked; the ones still ahead are the accent colour.
class TodayTimeline extends StatelessWidget {
  final Duration start;
  final Duration end;
  final List<Duration> times;
  final Duration now;

  const TodayTimeline({
    super.key,
    required this.start,
    required this.end,
    required this.times,
    required this.now,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = CustomTimeFormatter();
    final caption = Theme.of(context).textTheme.displaySmall?.copyWith(
          color: EyehelperColorScheme.lightGrey,
          fontSize: 10,
        );
    final window = (end - start).inMilliseconds;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        double x(Duration t) => window <= 0 ? 0 : width * (t - start).inMilliseconds / window;

        return SizedBox(
          height: 38,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 9,
                height: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F1E9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              for (final t in times)
                Positioned(
                  left: x(t) - 6,
                  top: 5,
                  child: _Dot(passed: t <= now),
                ),
              Positioned(
                left: 0,
                top: 22,
                child: Text(formatter.formatShort(start), style: caption),
              ),
              Positioned(
                right: 0,
                top: 22,
                child: Text(formatter.formatShort(end), style: caption),
              ),
              for (final t in times)
                Positioned(
                  left: x(t),
                  top: 22,
                  child: FractionalTranslation(
                    translation: const Offset(-0.5, 0),
                    child: Text(
                      t <= now ? '${formatter.formatShort(t)} ✓' : formatter.formatShort(t),
                      style: caption?.copyWith(
                        color: t <= now ? const Color(0xFF3B7D5A) : EyehelperColorScheme.mainDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final bool passed;

  const _Dot({required this.passed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: passed ? const Color(0xFF3B7D5A) : EyehelperColorScheme.activeColor,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: passed ? const Color(0xFF3B7D5A) : EyehelperColorScheme.activeColor,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
