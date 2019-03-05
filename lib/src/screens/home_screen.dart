import 'package:eyehelper/src/colors.dart';
import 'package:eyehelper/src/constants.dart';
import 'package:eyehelper/src/screens/eye_screen/eye_screen.dart';
import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  Map titles = {
    INDEX_STATISTICS_SCREEN: 'Статистика',
    INDEX_EYE_SCREEN: 'Упражнения',
    INDEX_NOTIFICATIONS_SCREEN: 'Уведомления'
  };

  Map screens = {
    INDEX_STATISTICS_SCREEN: Container(),
    INDEX_EYE_SCREEN: EyeScreen(),
    INDEX_NOTIFICATIONS_SCREEN: Container(),
  };

  Widget content = Text('hello world');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60.0, bottom: 40.0),
          child: Scaffold(
            body: screens[_currentIndex],
          ),
        ),

        Container(
          height: PREFERED_HEIGHT_FOR_CUSTOM_APPBAR,
          child: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: StandartStyle.transparent,
            flexibleSpace: ToolbarWavy(
                title: titles[_currentIndex],
                currentIndex: _currentIndex
            ),
          )
        ),

        Positioned(
          bottom: 0.0,
          child: BottomWavy(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
          ),
        )
      ],
    );
  }
}

