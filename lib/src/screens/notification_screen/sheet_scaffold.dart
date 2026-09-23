import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_card.dart';
import 'package:flutter/material.dart';

/// White bottom sheet with a grabber, rounded top and safe-area padding —
/// the frame every editor on the reminders tab lives in.
Future<T?> showAppSheet<T>(BuildContext context, {required WidgetBuilder builder}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    clipBehavior: Clip.antiAlias,
    builder: (context) => Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 20 + MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFD9E1DC),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 10),
          builder(context),
        ],
      ),
    ),
  );
}

class SheetTitle extends StatelessWidget {
  final String text;

  const SheetTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: appText(17, weight: FontWeight.w600),
      ),
    );
  }
}

/// Label with a square check on the left, the whole row tappable.
class SheetCheckRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SheetCheckRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: value ? EyehelperColorScheme.activeColor : Colors.transparent,
                border: Border.all(
                  color: value ? EyehelperColorScheme.activeColor : const Color(0xFFB9C3BD),
                  width: 1.5,
                ),
              ),
              child: value ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: appText(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
