import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/place.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:concordi_around/credential.dart';
import 'package:dio/dio.dart';
// TODO: Add session token for Google Places API calls
import 'package:uuid/uuid.dart';

class SearchBar extends StatefulWidget {
  final Function(Coordinate) coordinate;
  SearchBar({this.coordinate});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  String _sessionToken;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, MapNotifier mapNotifier, Widget child) =>
          Column(children: <Widget>[
        Container(
          margin: new EdgeInsets.only(
              left: 15.0,
              top: MediaQuery.of(context).padding.top + 5.0,
              right: 15.0),
          padding: EdgeInsets.only(bottom: 10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(constant.BORDER_RADIUS),
                color: Colors.white),
            child: Row(
              children: <Widget>[
                Container(
                  child: IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search"),
                    onTap: () {
                      showSearch(
                          context: context,
                          delegate: PositionedFloatingSearchBar(
                              coordinate: (Coordinate coordinate) =>
                                  {widget.coordinate(coordinate)}));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RaisedButton(
                    child: Text(mapNotifier.currentCampus),
                    textColor: Colors.white,
                    color: constant.COLOR_CONCORDIA,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.circular(constant.BORDER_RADIUS)),
                    onPressed: () {
                      if (mapNotifier.currentCampus == 'SGW') {
                        mapNotifier.setCampusString("LOY");
                        mapNotifier.toggleCampus(constant.LATLNG_LOYOLA);
                      } else {
                        mapNotifier.setCampusString("SGW");
                        mapNotifier.toggleCampus(constant.LATLNG_GM);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class PositionedFloatingSearchBar extends SearchDelegate<String> {
  final Function(Coordinate) coordinate;
  PositionedFloatingSearchBar({this.coordinate});

  // THIS IS THE EXIT SEARCH BUTTON ON THE LEFT "<-"
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  // THIS IS THE CLEAR BUTTON ON THE RIGHT "X"
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: query.length > 0
            ? _getSuggestions(query)
            : Future.value(List<Place>()),
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<Place> places;
            if (snapshot.hasData) {
              places = snapshot.data;
            } else {
              places = List<Place>();
            }
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  Place selected = places[index];
                  // TODO: use selected placeId to make a get request for place details then build coordinate
                  Navigator.pop(context);
                  // this.coordinate(_getLocationDetails(selected));
                },
                leading: Icon(Icons.place),
                title: Text(places[index].description),
              ),
              itemCount: places.length,
            );
          } else {
            return ListView();
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  static Future<List<Place>> _getSuggestions(String input) async {
    List<Place> _suggestions = [];

    if (input.isEmpty) {
      return _suggestions;
    }

    List<RoomCoordinate> rooms = BuildingSingleton()
        .getAllRooms()
        .where((room) => room.roomId.startsWith(input.toUpperCase()))
        .toList();

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String types = 'establishment';
    String locationSGW = '45.49612,-73.58012';
    String locationLOY = '45.45906,-73.63973';
    String radius = '500&strictbounds';

    String request1 =
        '$baseURL?input=$input&types=$types&location=$locationSGW&radius=$radius&key=$PLACES_API_KEY';
    Response response1 = await Dio().get(request1);

    String request2 =
        '$baseURL?input=$input&types=$types&location=$locationLOY&radius=$radius&key=$PLACES_API_KEY';
    Response response2 = await Dio().get(request2);

    final predictions1 = response1.data['predictions'];
    final predictions2 = response2.data['predictions'];

    for (var prediction in predictions1) {
      String placeId = prediction['place_id'];
      String description = prediction['description'];
      _suggestions.add(Place(placeId, description));
    }
    for (var prediction in predictions2) {
      String placeId = prediction['place_id'];
      String description = prediction['description'];
      _suggestions.add(Place(placeId, description));
    }
    for (var room in rooms) {
      _suggestions.add(Place(room.roomId, room.roomId));
    }

    return _suggestions;
  }
}
