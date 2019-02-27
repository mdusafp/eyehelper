import 'package:eyehelper/src/widgets/bootombar.dart';
import 'package:eyehelper/src/widgets/toolbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: ToolbarWavy(title: "Упражнения"),
      ),
      body: Container(child: Center(child: Text('nui'))),
      bottomNavigationBar: BottomWavy(
        onEyePress: () {},
        onStatisticsPress: () {},
        onNotificationPress: () {},
      ),
    );
  }
}
