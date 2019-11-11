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
            style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).accentColor,
            ),
          ),
          Text(label,
            style: Theme.of(context).textTheme.body1.copyWith(
              color: Theme.of(context).primaryColorDark
            ), 
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
