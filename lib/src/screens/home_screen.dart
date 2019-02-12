import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eyehelper'),
      ),
      body: Container(
        child: Center(
          child: Text("Home screen"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/profile');
          },
        ),
      ),
    );
  }
}