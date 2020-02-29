import 'dart:ui';
import 'package:concordi_around/provider/disability_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SidebarDrawer extends StatefulWidget {
  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  Widget build(BuildContext context) {
    //DisabilityNotifier disabilityNotifier = Provider.of<DisabilityNotifier>(context);

    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
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
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(20.0))),
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
              leading: Icon(Icons.calendar_today),
              title: Text('My Calendar'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Contact Us'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
