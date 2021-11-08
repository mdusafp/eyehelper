import 'package:flutter/material.dart';

class StatisticValue extends StatelessWidget {
  final String label;
  final String value;

  const StatisticValue({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 8.0,
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Theme.of(context).backgroundColor),
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Theme.of(context).backgroundColor.withOpacity(.65),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
