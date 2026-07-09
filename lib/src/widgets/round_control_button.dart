import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

class RoundControlButton extends StatelessWidget {
  final Function callback;
  final String imagePath;

  const RoundControlButton({
    Key? key,
    required this.callback,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassButton(
      width: 50,
      height: 50,
      useOwnLayer: true,
      glowColor: Theme.of(context).colorScheme.secondary,
      icon: Image.asset(imagePath, height: 20.0),
      onTap: () => callback(),
    );
  }
}
