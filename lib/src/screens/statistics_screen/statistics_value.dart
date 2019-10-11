import 'package:flutter/material.dart';
import 'package:eyehelper/src/colors.dart';

class StatisticValue extends StatelessWidget {
  final String label;
  final String value;

  const StatisticValue({Key key, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            value,
            style: StandardStyleTexts.title.copyWith(
              color: StandardStyleColors.activeColor,
            ),
          ),
          Text(label,
            style: StandardStyleTexts.display2, 
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
