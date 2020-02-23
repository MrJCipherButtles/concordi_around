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
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("40022345"),
              decoration: BoxDecoration(
                color: Color.fromRGBO(147, 35, 57, 1),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Text(
                  "JD",
                  style: TextStyle(fontSize: 40.0),
                ),
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
