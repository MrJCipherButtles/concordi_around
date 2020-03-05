import 'package:flutter/material.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:concordi_around/services/constants.dart' as constant;
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
  Coordinate _searchedStart = null;
  Coordinate _searchedDestination = null;

  Widget build(BuildContext context) {
    _searchedDestination = widget.destination;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
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
                                      coordinate: (Coordinate val) {
                                    setState(() {
                                      _searchedStart = val;
                                    });
                                  }),
                                );
                              },
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: (_searchedDestination == null)
                                    ? "Enter Destination"
                                    : _searchedDestination.toString(),
                                icon: Icon(Icons.location_on),
                              ),
                              readOnly: true,
                              onTap: () {
                                showSearch(
                                  context: context,
                                  delegate: PositionedFloatingSearchBar(
                                      coordinate: (Coordinate val) {
                                    setState(() {
                                      _searchedDestination = val;
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
                          margin:
                              EdgeInsets.only(top: 5, left: 2.5, right: 2.5),
                          decoration: BoxDecoration(
                              color: constant.COLOR_CONCORDIA,
                              borderRadius: BorderRadius.circular(
                                  constant.BORDER_RADIUS)),
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
                  ? _showToast(context)
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
      ),
    );
  }


  //The snackbar is current not working but is a QoL implementation, will be added as a bug
  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.removeCurrentSnackBar();
    scaffold.showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      content: Text("Destination is not set"),
    ));
  }
}
