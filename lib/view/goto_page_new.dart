import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:concordi_around/widget/search/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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
                          TextField(
                            decoration: InputDecoration(
                              hintText: (_searchedStart == null)
                                  ? "Current Location"
                                  : _searchedStart.toString(),
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
                                  });
                                }),
                              );
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: (_searchedDestination == null)
                                  ? widget.destination == null
                                      ? "Enter Destination"
                                      : widget.destination
                                  : _searchedDestination.toString(),
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, left: 2.5, right: 2.5),
                        decoration: BoxDecoration(
                            color: constant.COLOR_CONCORDIA,
                            borderRadius:
                                BorderRadius.circular(constant.BORDER_RADIUS)),
                        child: IconButton(
                            icon: Icon(Icons.directions_car),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.directions_transit),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.directions_bike),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          icon: Icon(Icons.directions_walk),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
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
            _searchedDestination == null
                ? null
                : {
                    _searchedStart == null
                        ? widget.confirmDirection(new List<Coordinate>.from([
                            //this is to return the current location however there is a type conflict
                            //unable to test further because current location needs outside navigation
                            //TODO: update to the right type
                            //widget._current,
                            _searchedDestination
                          ])) //this doesn't work because of outside isnt implemented yet
                        : widget.confirmDirection(new List<Coordinate>.from(
                            [_searchedStart, _searchedDestination])),
                    Navigator.pop(context)
                  };
          }),
    );
  }
}
