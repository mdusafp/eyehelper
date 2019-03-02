import 'package:eyehelper/src/screens/eye_screen.dart';
import 'package:eyehelper/src/widgets/bootom_bar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  Map screens = {
    0: Text('Statistic'),
    1: EyeScreen(),
    2: Text('Notifications'),
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

        PreferredSize(
          preferredSize: Size.fromHeight(PREFERED_HEIGHT_FOR_CUSTOM_APPBAR),
          child: AppBar(
            elevation: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            flexibleSpace: ToolbarWavy(title: "Упражнения"),
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

