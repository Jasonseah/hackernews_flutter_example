import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('News Object'),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app
            },
          ),
        ],
      ),
    );
  }
}
