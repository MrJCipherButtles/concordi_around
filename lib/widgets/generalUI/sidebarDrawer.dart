import 'package:flutter/material.dart';

class SidebarDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('ConcordiAround'),
              decoration: BoxDecoration(
                color: Color.fromRGBO(147, 35, 57, 1),
              ),
            ),
            ListTile(
              title: Text('Placeholder 1'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: Text('Placeholder 2'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      ),
      );
  }
}