import 'package:eyehelper/src/theme.dart';
import 'package:eyehelper/src/widgets/app_background.dart';
import 'package:eyehelper/src/widgets/custom_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
          "Об упражнениях",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(context).primaryColorDark),
        ),
        // Balances the trailing close button so the title stays centered.
        leading: const SizedBox(width: 40),
        actions: [
          GlassIconButton(
            size: 40,
            icon: Icon(Icons.close, color: Theme.of(context).primaryColorDark),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
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
                  text: 'В приложении используется информация об упражнениях по системе Аветисова.',
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: 'Для того чтобы получить подробную информацию, нажмите на кнопку ниже.',
                ),
                TextSpan(text: '\n\n'),
                TextSpan(
                  text: 'Внимание! ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                    text:
                        'Перед выполнением упражнений настоятельно рекомендуем вам обратиться к вашему лечащему врачу за консультацией. Разработчики не несут ответственность за любой косвенный, случайный или неумышленный вред, вызванный в связи с использованием приложения.'),
              ])),
            ),
            Container(height: 12.0),
            RoundCustomButton(
              parentSize: MediaQuery.of(context).size,
              onPressed: () {
                launch(
                    "http://ktyis.ru/wp-content/uploads/%D0%93%D0%B8%D0%BC%D0%BD%D0%B0%D1%81%D1%82%D0%B8%D0%BA%D0%B0-%D0%B4%D0%BB%D1%8F-%D0%B3%D0%BB%D0%B0%D0%B7-%D0%BF%D0%BE-%D0%90%D0%B2%D0%B5%D1%82%D0%B8%D1%81%D0%BE%D0%B2%D1%83.pdf");
              },
              child: Text(
                "Подробнее",
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
