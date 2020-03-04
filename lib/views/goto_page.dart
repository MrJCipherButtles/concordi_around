import 'package:flutter/material.dart';

class GotoPage extends StatefulWidget {
  @override
  _GotoPageState createState() => _GotoPageState();
}

class _GotoPageState extends State<GotoPage> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10),
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Current Location",
                              icon: Icon(Icons.my_location),
                            ),
                            enabled: false,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Destination",
                              icon: Icon(Icons.location_on),
                            ),
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.swap_vert),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.directions_car),
                        color: Colors.grey,
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
