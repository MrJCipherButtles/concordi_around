import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SidebarDrawer extends StatefulWidget {
  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  //DisabilityModeInfo _disabilityNotifier;
  bool _disabilityModeOn = DisabilityModeInfo().disabilityModeState;

  Widget build(BuildContext context) {
    final _disabilityNotifier = Provider.of<DisabilityModeInfo>(context);
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                Color.fromRGBO(147, 35, 57, 1),
                Color.fromRGBO(147, 35, 57, 0.5)
              ])),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("John Doe"),
                accountEmail: Text("40022345"),
                decoration: BoxDecoration(
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
              Card(
                child: ListTile(
                  title: Text('Calendar'),
                  onTap: () {
                    // Update the state of the app.
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Disability Mode'),
                  onTap: () {
                    // Update the state of the app.
                  },
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ListTile(
                            title: Text(
                      'Disability Mode',
                    ))),
                    StatefulBuilder(
                      builder: (context, _setState) => Checkbox(
                        value: _disabilityModeOn,
                        onChanged: (bool value) {
                          _setState(() => _disabilityModeOn = value);
                          _disabilityNotifier.disabilityModeState = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DisabilityModeInfo with ChangeNotifier {
  bool _disabilityModeState = false;

  bool get disabilityModeState => _disabilityModeState;
  set disabilityModeState(bool newState) {
    _disabilityModeState = newState;
  }
  bool switchState(){
    _disabilityModeState ? _disabilityModeState = false : _disabilityModeState = true;
    //notifyListeners();
    print(_disabilityModeState.toString());
    return _disabilityModeState;
  }
}

// class ListenerTester{
// final disabilityListener = DisabilityModeInfo();
// void listenhere(){
// disabilityListener.addListener(_listener);
// }
// void _listener() {
//   print('**********************It changed!');
// }
// }