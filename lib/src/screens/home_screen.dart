import 'package:eyehelper/src/widgets/bootombar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget content = Text('hello world');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: ToolbarWavy(title: "Упражнения"),
      ),
      body: content,
      bottomNavigationBar: BottomWavy(
        onEyePress: () {
          setState(() {
            content = Text('Eye');
          });
        },
        onStatisticsPress: () {
          setState(() {
            content = Text('Statistic');
          });
        },
        onNotificationPress: () {
          setState(() {
            content = Text('Notifications');
          });
        },
      ),
    );
  }
}
