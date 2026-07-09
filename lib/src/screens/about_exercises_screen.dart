import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_background.dart';
import 'package:eyehelper/src/screens/learn_more_screen.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class AboutExercisesScreen extends StatefulWidget {
  @override
  _AboutExercisesScreenState createState() => _AboutExercisesScreenState();
}

class _AboutExercisesScreenState extends State<AboutExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      backgroundColor: EyehelperColorScheme.backgroundWhite,
      background: const AppBackground(),
      topEdgeFade: false,
      appBar: GlassAppBar(
        title: Text(
          context.t.about.title,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        leading: GlassIconButton(
          size: 40,
          icon: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).primaryColorDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // Balances the leading back button so the title stays centered.
        actions: const [SizedBox(width: 40)],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).padding.top + 56,
            ),
            Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.secondary,
              size: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                  text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: [
                TextSpan(
                  text: context.t.about.body1,
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: context.t.about.body2,
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: context.t.about.warningLabel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        context.t.about.disclaimer),
              ])),
            ),
            Container(height: 12.0),
            RoundCustomButton(
              parentSize: MediaQuery.of(context).size,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LearnMoreScreen()),
                );
              },
              child: Text(
                context.t.about.moreButton,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            Container(height: 32.0),
          ],
        ),
      ),
    );
  }
}
