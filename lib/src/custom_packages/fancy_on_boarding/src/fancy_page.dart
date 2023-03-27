import 'package:eyehelper/src/custom_packages/fancy_on_boarding/src/page_model.dart';
import 'package:flutter/material.dart';

class FancyPage extends StatelessWidget {
  final PageModel model;
  final double percentVisible;

  FancyPage({
    required this.model,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: model.color,
        ),
        width: double.infinity,
        child: Opacity(
          opacity: percentVisible,
          child: Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //Transform(
              // transform: Matrix4.translationValues(
              //   0.0, 50.0 * (1.0 - percentVisible), 0.0),
              //child:
              Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: _renderImageAsset(model.heroAssetPath,
                    width: 200, height: 200, color: model.heroAssetColor),
              ),
              //),
              Transform(
                transform: Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                child:
                    Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0), child: model.title),
              ),
              Transform(
                transform: Matrix4.translationValues(0.0, 30.0 * (1.0 - percentVisible), 0.0),
                child: Padding(padding: EdgeInsets.only(bottom: 75.0), child: model.body),
              ),
            ]),
          ),
        ));
  }
}

Widget _renderImageAsset(String assetPath, {double width = 24, double height = 24, Color? color}) {
  return Image.asset(
    assetPath,
    color: color,
    width: width,
    height: height,
  );
}
