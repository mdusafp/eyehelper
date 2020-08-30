import 'package:flutter/material.dart';

class PageModel {
  final Color color;
  final String heroAssetPath;
  final Color heroAssetColor;
  final Widget title;
  final Widget body;

  PageModel({
    @required this.color,
    @required this.heroAssetPath,
    this.heroAssetColor,
    this.title,
    this.body,
  })  : assert(title != null),
        assert(body != null),
        assert(color != null),
        assert(heroAssetPath != null);
}
