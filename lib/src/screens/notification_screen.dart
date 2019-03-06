import 'package:eyehelper/src/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> schedule = [
    {
      'name': 'Пн',
      'isActive': false,
      'start': '',
      'end': '',
    },
    {
      'name': 'Вт',
      'isActive': true,
      'start': '',
      'end': '',
    },
    {
      'name': 'Ср',
      'isActive': true,
      'start': '',
      'end': '',
    },
    {
      'name': 'Чт',
      'isActive': false,
      'start': '',
      'end': '',
    },
    {
      'name': 'Пт',
      'isActive': true,
      'start': '',
      'end': '',
    },
    {
      'name': 'Сб',
      'isActive': false,
      'start': '',
      'end': '',
    },
    {
      'name': 'Вс',
      'isActive': false,
      'start': '',
      'end': '',
    },
  ];

  Widget _buildDayItem(BuildContext context, int index) {
    final day = schedule[index];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Text(day['name']),
            Expanded(
                child: SizedBox()), // TODO: provide selector instead of this
            Switch(
              value: day['isActive'],
              activeColor: StandartStyle.activeColor,
              onChanged: (value) {
                setState(() => day['isActive'] = value);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget notificationSwitch = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Напоминания включены',
          style: TextStyle(fontSize: 14.0, color: StandartStyle.activeColor),
        ),
        Switch(
          value: true,
          onChanged: (value) {},
          activeColor: StandartStyle.activeColor,
        ),
      ],
    );

    final Widget applyAll = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          'Применить ко всем',
        ),
        Checkbox(
          value: true,
          onChanged: (value) {},
          activeColor: StandartStyle.activeColor,
        )
      ],
    );

    final Widget saveButton = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          'Сохранить',
          style: TextStyle(color: Colors.white),
        ),
        color: StandartStyle.activeColor,
        onPressed: () {},
      ),
    );

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: const EdgeInsets.only(top: 50.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  notificationSwitch,
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'Выберите время, в которое вы находитесь за компьютером, приложение будет напоминать вам делать упражнения.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  applyAll,
                ]),
              ),
            ),
            SliverFixedExtentList(
              itemExtent: 80.0,
              delegate: SliverChildBuilderDelegate(
                _buildDayItem,
                childCount: schedule.length,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 50.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'Как часто вы хотите, чтобы приложение напоминало вам делать упражнения?',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  saveButton,
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
