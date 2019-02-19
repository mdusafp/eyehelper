import 'package:flutter/material.dart';
import 'package:eyehelper/src/item.dart';


class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eyehelper'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            children: _items.map(_buildItem).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('/profile');
        },
        child: Icon(Icons.import_contacts),
      ),
    );
  }

  Widget _buildItem(Item item) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    child: ListTile(
      title: Text(item.name),
      subtitle: Text(item.description),
      onTap: () {},
    ),
  );
}