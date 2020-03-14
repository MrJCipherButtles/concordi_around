import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:flutter/material.dart';
import 'package:concordi_around/view/shuttle_page.dart';

import '../global.dart' as global;

class SidebarDrawer extends StatefulWidget {
  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  Widget build(BuildContext context) {
    bool _isDisabilityOn = global.disabilityMode;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(constant.BORDER_RADIUS),
          bottomRight: Radius.circular(constant.BORDER_RADIUS)),
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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(constant.BORDER_RADIUS))),
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
                    leading: Icon(Icons.airport_shuttle),
                    title: Text('Shuttle Schedule'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShuttlePage()));
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
                    global.disabilityMode = value;
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        backgroundColor:
            global.disabilityMode ? constant.COLOR_CONCORDIA : null,
        content: global.disabilityMode
            ? Text('Disability Mode turned ON')
            : Text('Disability Mode turned OFF'),
        action: SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              global.disabilityMode = global.disabilityMode ? false : true;
              _showToast(context);
            }),
      ),
    );
  }
}
