import 'dart:ui';
import 'package:flutter/material.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              //TODO: remove hard-coded info
              accountName: Text("John Doe"),
              accountEmail: Text("40022345"),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(147, 35, 57, 1),
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(20.0))),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                //TODO: remove hard-coded info
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
