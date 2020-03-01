import 'dart:ui';
import 'package:concordi_around/global.dart' as globals;
import 'package:flutter/material.dart';

class SidebarDrawer extends StatefulWidget {
  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  Widget build(BuildContext context) {
    bool _isDisabilityOn = globals.disabilityMode;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Drawer(
        child: Column(
          children: <Widget>[
            /*
            Column and Expanded widget are needed to format the disability toggle checkbox
            at the bottom of the drawer
            */
            Expanded(
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
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.pop(context);
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
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('About'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.pop(context);
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            /*
            StatefulBuilder is used because the toggle state doesnt change on the drawer when
            using just a Checkbox or CheckboxListTile
            */
            StatefulBuilder(
              builder: (context, _setState) => CheckboxListTile(
                secondary: Icon(Icons.accessible_forward),
                activeColor: Color.fromRGBO(147, 35, 57, 1),
                title: Text("Disability Mode"),
                value: _isDisabilityOn,
                onChanged: (bool value) {
                  _setState(() {
                    _isDisabilityOn = value;
                    globals.disabilityMode = value;
                    /*
                    TODO: replace the global variable for the disability mode for a "config" file
                    where the choice of the user will be saved even after the app restarts
                    */
                    _showToast(context);
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(
      SnackBar(
        //elevation: 6.0,
        //shape: null,
        
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
         behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(147, 35, 57, 1),
        content: globals.disabilityMode
            ? Text('Disability Mode turned ON')
            : Text('Disability Mode turned OFF'),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              //scaffold.hideCurrentSnackBar;
              globals.disabilityMode = globals.disabilityMode ? false : true;
              _showToast(context);
            }),
      ),
    );
  }
}
