import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:concordi_around/widget/search/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../global.dart' as global;

class GotoPage extends StatefulWidget {
  final Position _current;
  final Coordinate destination;
  final Function(List<Coordinate>) confirmDirection;

  const GotoPage(this._current, {this.confirmDirection, this.destination});

  @override
  _GotoPageState createState() => _GotoPageState();
}

class _GotoPageState extends State<GotoPage> {
  Coordinate _searchedStart;
  Coordinate _searchedDestination;

  @override
  void initState() {
    super.initState();
    _searchedStart = Coordinate(widget._current.latitude,
        widget._current.longitude, '', "Your location", '');
    _searchedDestination = widget.destination;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 5.0),
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
                          //This field is always "filled" by a value, default is current location
                          TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: _searchedStart == null
                                      ? Colors.grey
                                      : Colors.black),
                              hintText: (_searchedStart != null)
                                  ? _searchedStart.toString()
                                  : "Choose starting point",
                              icon: Icon(Icons.my_location),
                            ),
                            readOnly: true,
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PositionedFloatingSearchBar(
                                    coordinate: (Future<Coordinate> val) {
                                  setState(() async {
                                    _searchedStart = await val;
                                    //Used to force a second refresh of the view
                                    setState(() {});
                                  });
                                }),
                              );
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: _searchedDestination == null
                                      ? Colors.grey
                                      : Colors.black),
                              hintText: (_searchedDestination != null)
                                  ? _searchedDestination.toString()
                                  : 'Choose destination',
                              icon: Icon(Icons.location_on),
                            ),
                            readOnly: true,
                            onTap: () {
                              showSearch(
                                context: context,
                                delegate: PositionedFloatingSearchBar(
                                    coordinate: (Future<Coordinate> val) {
                                  setState(() async {
                                    _searchedDestination = await val;
                                    //Used to force a second refresh of the view
                                    setState(() {});
                                  });
                                }),
                              );
                            },
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
                    Expanded(flex: 1, child: Container()),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: ToggleButtons(
                          selectedColor: Colors.white,
                          color: Colors.black,
                          fillColor: Colors.transparent,
                          renderBorder: false,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constant.BORDER_RADIUS),
                                color: global.travelMode[0]
                                    ? constant.COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_car),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constant.BORDER_RADIUS),
                                color: global.travelMode[1]
                                    ? constant.COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_transit),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constant.BORDER_RADIUS),
                                color: global.travelMode[2]
                                    ? constant.COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_bike),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 6,
                                  minHeight: double.infinity),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    constant.BORDER_RADIUS),
                                color: global.travelMode[3]
                                    ? constant.COLOR_CONCORDIA
                                    : Colors.transparent,
                              ),
                              child: Icon(Icons.directions_walk),
                            ),
                          ],
                          isSelected: global.travelMode,
                          onPressed: (int index) {
                            setState(() {
                              global.travelMode = [false, false, false, false];
                              global.travelMode[index] = true;
                            });
                          }),
                    ),
                    //Add a flexible padding to the row
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: constant.COLOR_CONCORDIA,
          foregroundColor: Colors.white,
          child: Text("GO"),
          onPressed: () {
            if (_searchedDestination != null) {
              widget.confirmDirection(new List<Coordinate>.from(
                  [_searchedStart, _searchedDestination]));
              Navigator.pop(context);
            }
          }),
    );
  }
}
