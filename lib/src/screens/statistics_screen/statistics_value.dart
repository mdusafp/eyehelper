import 'package:flutter/material.dart';

class StatisticValue extends StatelessWidget {
  final String label;
  final String value;

  const StatisticValue({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
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
                        .titleLarge
                        ?.copyWith(color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.surface.withValues(alpha: .65),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
