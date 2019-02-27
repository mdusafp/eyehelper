import 'package:eyehelper/src/custom_elements/bootombar.dart';
import 'package:eyehelper/src/custom_elements/toolbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ToolbarWavy(title: "Упражнения"),
      bottomNavigationBar: BottomWavy(onBottomBarTap: (value) {
        print(value);
      }),
    );
  }
}
