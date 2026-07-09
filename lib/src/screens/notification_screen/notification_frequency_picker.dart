import 'package:eyehelper/src/screens/notification_screen/dtos/frequency.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/notification_frequency.dart';
import 'package:eyehelper/i18n/tr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

typedef void OnChange(Frequency frequency);

class NotificationFrequencyPicker extends StatefulWidget {
  final Frequency initialFrequency;
  final OnChange onChange;

  const NotificationFrequencyPicker({
    Key? key,
    required this.initialFrequency,
    required this.onChange,
  }) : super(key: key);

  @override
  NotificationFrequencyPickerState createState() => NotificationFrequencyPickerState();
}

class NotificationFrequencyPickerState extends State<NotificationFrequencyPicker> {
  List<NotificationFrequency>? _frequencies;
  int? _selectedFrequencyIndex;
  FixedExtentScrollController? _controller;

  final double _modalHeight = 128.0;

  @override
  initState() {
    // _frequencies = [
    //   new NotificationFrequency('frequency.hourOne', new Duration(hours: 1)),
    //   new NotificationFrequency('frequency.hoursTwo', new Duration(hours: 2)),
    //   new NotificationFrequency('frequency.hoursTwo', new Duration(hours: 4)), // 4 часа, а не  часов
    //   new NotificationFrequency('frequency.hoursMany', new Duration(hours: 8)),
    // ];
    _selectedFrequencyIndex = frequencies.indexWhere((frequency) {
      return frequency.type == widget.initialFrequency.type;
    });
    if (_selectedFrequencyIndex == null || _selectedFrequencyIndex! < 0) {
      _selectedFrequencyIndex = 0;
    }
    //_selectedFrequency = _frequencies[index];
    _controller = new FixedExtentScrollController(initialItem: _selectedFrequencyIndex!);

    super.initState();
  }

  String _getFrequencyTitle(NotificationFrequency frequency) {
    String timesPer = context.t.notifications.timesPer;
    String hours = frequency.duration.inHours.toString();
    String postfix = trKey(context, frequency.localeId);
    // plural can't handle 3/4 hours in russian there is problem that's why i do that
    return '$timesPer $hours $postfix';
  }

  Widget _buildModal(Function(int) onSelect) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  left: 32.0,
                  right: 32.0,
                  top: 32.0,
                ),
                child: Text(
                  context.t.notifications.frequencyQuestion,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Theme.of(context).primaryColorDark),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: SizedBox(
                  height: _modalHeight,
                  child: CupertinoPicker(
                    scrollController: _controller,
                    backgroundColor: Colors.transparent,
                    itemExtent: _modalHeight / 2,
                    children: frequencies.map((frequency) {
                      return Center(
                        child: Text(trKey(context, frequency.title),
                            style: Theme.of(context).textTheme.bodyMedium),
                      );
                    }).toList(),
                    onSelectedItemChanged: onSelect,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    HSLColor activeCardColor = HSLColor.fromColor(themeData.colorScheme.secondary);

    return InkWell(
      onTap: () async {
        Frequency selectedFrequency = frequencies[_selectedFrequencyIndex ?? 0];
        await showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            context: context,
            builder: (context) => _buildModal((index) {
                  setState(() {
                    _selectedFrequencyIndex = index;
                    // reinit controller to set initialItem
                    _controller = new FixedExtentScrollController(initialItem: index);
                  });
                }));
        selectedFrequency = frequencies[_selectedFrequencyIndex ?? 0];
        widget.onChange(selectedFrequency);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              activeCardColor.withLightness(.5).toColor(),
              activeCardColor.withLightness(.4).toColor()
            ],
          ),
          boxShadow: [
            const BoxShadow(
              color: Color(0x3A000000),
              offset: Offset(0.0, 6.0),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
          child: DefaultTextStyle(
            style: themeData.textTheme.headlineMedium!.copyWith(
              color: themeData.colorScheme.surface.withOpacity(.85),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.access_time, color: themeData.colorScheme.surface),
                      ),
                      Text(
                        trKey(context, frequencies[_selectedFrequencyIndex ?? 0].title),
                        style: themeData.textTheme.titleLarge
                            ?.copyWith(color: themeData.colorScheme.surface),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(context.t.notifications.weWillNotify),
                ),
                Text(
                  context.t.common.change,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
