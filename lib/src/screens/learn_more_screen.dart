import 'package:eyehelper/i18n/tr.dart';
import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Article-style reader explaining how the eye exercises work.
/// Content comes from the `learnMore` translation namespace.
class LearnMoreScreen extends StatelessWidget {
  const LearnMoreScreen({Key? key}) : super(key: key);

  static const _accent = EyehelperColorScheme.activeColor;
  static const _dark = EyehelperColorScheme.mainDark;
  static const _grey = EyehelperColorScheme.lightGrey;

  @override
  Widget build(BuildContext context) {
    final learn = context.t.learnMore;

    return GlassScaffold(
      backgroundColor: EyehelperColorScheme.backgroundWhite,
      background: const AppBackground(),
      topEdgeFade: false,
      appBar: GlassAppBar(
        leading: GlassIconButton(
          size: 40,
          icon: const Icon(Icons.arrow_back_ios_new, color: _dark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: const [SizedBox(width: 40)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 52,
            bottom: MediaQuery.of(context).padding.bottom + 32,
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                learn.title,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),
              const SizedBox(height: 16),
              _paragraph(learn.intro1),
              const SizedBox(height: 12),
              _paragraph(learn.intro2),
              const SizedBox(height: 22),
              for (final part in learn.parts) _partCard(part),
              const SizedBox(height: 4),
              _paragraph(learn.tips),
              const SizedBox(height: 20),
              _disclaimer(learn.warningLabel, learn.disclaimer),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paragraph(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 15, height: 1.45, color: _dark),
    );
  }

  Widget _partCard(dynamic part) {
    final List<dynamic> exercises = part.exercises;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        useOwnLayer: true,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              part.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _accent,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              part.subtitle,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.35,
                fontStyle: FontStyle.italic,
                color: _grey,
              ),
            ),
            const SizedBox(height: 14),
            for (int i = 0; i < exercises.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i == exercises.length - 1 ? 0 : 14),
                child: _exercise(exercises[i]),
              ),
          ],
        ),
      ),
    );
  }

  Widget _exercise(dynamic exercise) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7, right: 10),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(color: _accent, shape: BoxShape.circle),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                exercise.text,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.4,
                  color: _dark.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _disclaimer(String warningLabel, String disclaimer) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 12.5, height: 1.4, color: _grey),
        children: [
          TextSpan(
            text: warningLabel,
            style: const TextStyle(fontWeight: FontWeight.bold, color: _accent),
          ),
          TextSpan(text: disclaimer),
        ],
      ),
    );
  }
}
