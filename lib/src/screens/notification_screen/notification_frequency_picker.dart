import 'package:eyehelper/src/screens/notification_screen/dtos/frequency.dart';
import 'package:eyehelper/src/screens/notification_screen/dtos/notification_frequency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:eyehelper/src/locale/Localizer.dart';
import 'package:eyehelper/src/locale/ru.dart';

typedef void OnChange(Frequency frequency);

class NotificationFrequencyPicker extends StatefulWidget {
  final Frequency initialFrequency;
  final OnChange onChange;

  const NotificationFrequencyPicker({
    Key key,
    @required this.initialFrequency,
    @required this.onChange,
  }) : super(key: key);

  @override
  NotificationFrequencyPickerState createState() => NotificationFrequencyPickerState();
}

class NotificationFrequencyPickerState extends State<NotificationFrequencyPicker> {
  List<NotificationFrequency> _frequencies;
  int _selectedFrequencyIndex;
  FixedExtentScrollController _controller;

  final double _modalHeight = 128.0;

  @override
  initState() {
    // _frequencies = [
    //   new NotificationFrequency(LocaleId.one_hour, new Duration(hours: 1)),
    //   new NotificationFrequency(LocaleId.two_hours, new Duration(hours: 2)),
    //   new NotificationFrequency(LocaleId.two_hours, new Duration(hours: 4)), // 4 часа, а не  часов
    //   new NotificationFrequency(LocaleId.many_hours, new Duration(hours: 8)),
    // ];
    _selectedFrequencyIndex = frequencies.indexWhere((frequency) {
      return frequency.type == widget.initialFrequency.type;
    });
    if (_selectedFrequencyIndex < 0 || _selectedFrequencyIndex == null) {
      _selectedFrequencyIndex = 0;
    }
    //_selectedFrequency = _frequencies[index];
    _controller = new FixedExtentScrollController(initialItem: _selectedFrequencyIndex);

    super.initState();
  }

  String _getFrequencyTitle(NotificationFrequency frequency) {
    String timesPer = Localizer.getLocaleById(LocaleId.times_per, context);
    String hours = frequency.duration.inHours.toString();
    String postfix = Localizer.getLocaleById(frequency.localeId, context);
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
                  Localizer.getLocaleById(LocaleId.exercise_frequency, context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .display2
                      .copyWith(color: Theme.of(context).primaryColorDark),
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
                        child: Text(Localizer.getLocaleById(frequency.title, context),
                            style: Theme.of(context).textTheme.body1),
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
    HSLColor activeCardColor = HSLColor.fromColor(themeData.accentColor);

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
        selectedFrequency = frequencies[_selectedFrequencyIndex];
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
            style: themeData.textTheme.display1.copyWith(
              color: themeData.backgroundColor.withOpacity(.85),
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
                        child: Icon(Icons.access_time, color: themeData.backgroundColor),
                      ),
                      Text(
                        Localizer.getLocaleById(
                            frequencies[_selectedFrequencyIndex].title, context),
                        style: themeData.textTheme.title.copyWith(color: themeData.backgroundColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(Localizer.getLocaleById(LocaleId.we_will_notify, context)),
                ),
                Text(
                  Localizer.getLocaleById(LocaleId.change, context),
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
