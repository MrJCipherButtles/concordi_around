import 'package:concordi_around/credential.dart';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/list_item.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SearchBar extends StatefulWidget {
  final Function(Future<Coordinate>) coordinate;
  SearchBar({this.coordinate});
  static PlaceCoordinate searchResult;

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
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
                              coordinate: (Future<Coordinate> coordinate) =>
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
  final Function(Future<Coordinate>) coordinate;
  List<ListItem> _history;
  var uuid = Uuid();
  String _sessionToken;
  int _lastKnownQueryLength = 0;

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

  // Every time the search query changes
  // this method is called
  @override
  Widget buildSuggestions(BuildContext context) {
    // If search was unfocused and refocused but no change
    if (_lastKnownQueryLength == query.length) {
      // then build ListView from history
      if (_history != null) {
        return ListView.builder(
          itemCount: _history.length,
          itemBuilder: (context, index) {
            if (_history[index] is HeadingItem) {
              return ListTile(
                title: Text(
                  _history[index].description,
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            } else {
              return ListTile(
                onTap: () {
                  PlaceItem selected = _history[index];
                  Navigator.pop(context);
                  this.coordinate(_getPlaceDetails(selected.placeId));
                },
                leading: Icon(Icons.place),
                title: Text(_history[index].description),
              );
            }
          },
        );
      }
      return ListView();
    }

    // Update last known query length variable
    _lastKnownQueryLength = query.length;

    // If no available history, then fetch suggestions
    // Must await for fetch to conclude before building
    return FutureBuilder(
        // start fetching when search query is not empty
        future: query.length > 0
            ? _getSuggestions(query)
            : Future.value(List<ListItem>()),
        builder:
            (BuildContext context, AsyncSnapshot<List<ListItem>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<ListItem> places;
            if (snapshot.hasData) {
              places = snapshot.data;
            } else {
              places = List<ListItem>();
            }
            return ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                if (places[index] is HeadingItem) {
                  return ListTile(
                    title: Text(
                      places[index].description,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  );
                } else {
                  return ListTile(
                    onTap: () {
                      PlaceItem selected = places[index];
                      Navigator.pop(context);
                      this.coordinate(_getPlaceDetails(selected.placeId));
                    },
                    leading: Icon(Icons.place),
                    title: Text(places[index].description),
                  );
                }
              },
            );
          } else {
            return ListView();
          } // else nothing to build and return empty ListView
        });
  }

  // Every time we submit a search query
  // this method executes
  // buildResults (a.k.a onSubmitted) must be implemented, but does
  // not bring any value other than collapses the keyboard on-screen
  @override
  Widget buildResults(BuildContext context) {
    if (_history != null) {
      return ListView.builder(
        itemCount: _history.length,
        itemBuilder: (context, index) {
          if (_history[index] is HeadingItem) {
            // Header tile
            return ListTile(
              title: Text(
                _history[index].description,
                style: Theme.of(context).textTheme.headline,
              ),
            );
          } else {
            // Result tile
            return ListTile(
              onTap: () {
                PlaceItem selected = _history[index];
                Navigator.pop(context);
                this.coordinate(_getPlaceDetails(selected.placeId));
                // session token must be cleared after getting place details
                _sessionToken = null;
              },
              leading: Icon(Icons.place),
              title: Text(_history[index].description),
            );
          }
        },
      );
    }
    // If history is null, return empty ListView
    return ListView();
  }

  // Google Places API autocomplete requests
  Future<List<ListItem>> _getSuggestions(String input) async {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    List<ListItem> _suggestions = [];

    if (input.isEmpty) {
      return _suggestions;
    }

    List<RoomCoordinate> rooms = BuildingSingleton()
        .getAllRooms()
        .where((room) => room.roomId.startsWith(input.toUpperCase()))
        .toList();

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String locationSGW = '45.49612,-73.58012';
    String locationLOY = '45.45906,-73.63973';
    String radius = '500&strictbounds';

    // SGW autocomplete suggestions
    String request1 =
        '$baseURL?input=$input&location=$locationSGW&radius=$radius&sessiontoken=$_sessionToken&key=$PLACES_API_KEY';
    Response response1 = await Dio().get(request1);

    // LOY autocomplete suggestions
    String request2 =
        '$baseURL?input=$input&location=$locationLOY&radius=$radius&sessiontoken=$_sessionToken&key=$PLACES_API_KEY';
    Response response2 = await Dio().get(request2);

    final predictions1 = response1.data['predictions'];
    final predictions2 = response2.data['predictions'];

    // ListView header + items for SGW if exists
    if (predictions1.isNotEmpty) {
      _suggestions.add(HeadingItem('SGW'));
    }
    for (var prediction in predictions1) {
      String placeId = prediction['place_id'];
      String description = prediction['description'];
      _suggestions.add(PlaceItem(placeId, description));
    }

    // ListView header + items for LOY if exists
    if (predictions2.isNotEmpty) {
      _suggestions.add(HeadingItem('Loyola'));
    }
    for (var prediction in predictions2) {
      String placeId = prediction['place_id'];
      String description = prediction['description'];
      _suggestions.add(PlaceItem(placeId, description));
    }

    // ListView header + items for Rooms if exists
    if (rooms.isNotEmpty) {
      _suggestions.add(HeadingItem('Rooms'));
    }
    for (var room in rooms) {
      _suggestions.add(PlaceItem(room.roomId, room.roomId));
    }

    // Set history for buildResults() method
    _history = _suggestions;

    return _suggestions;
  }

  // Google places API request for Place Details
  Future<Coordinate> _getPlaceDetails(String placeId) async {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }

    // If place id is empty, then return null
    if (placeId.isEmpty) {
      return null;
    }

    // If place id is a room id, then return the room coordinate
    List<RoomCoordinate> rooms = BuildingSingleton().getAllRooms();
    for (var room in rooms) {
      if (room.roomId == placeId) {
        return room;
      }
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/place';
    String fields = 'geometry,name,formatted_phone_number,formatted_address,website,photos,opening_hours';

    // Send place details request
    String request =
        '$baseURL/details/json?place_id=$placeId&fields=$fields&sessiontoken=$_sessionToken&key=$PLACES_API_KEY';
    Response response = await Dio().get(request);
    // session token must be cleared after getting place details
    _sessionToken = null;

    //Create Coordinate return type using place details for CameraPosition onto place
    final result = response.data['result'];
    final geometry = result['geometry'];
    final location = geometry['location'];
    
    double lat = location['lat'];
    double lng = location['lng'];
    String title = result['name'];
    String address = result['formatted_address'];
    String phone = result['formatted_phone_number'];
    String website = result['website'];
    bool openClosed;
    if(result['opening_hours'] != null){
      openClosed = result['opening_hours']['open_now'];
    }
    dynamic photosResult = result['photos'];
    List<String> pictures = List<String>();

    if(photosResult != null && result['photos'].length > 2){
      for(int i = 0; i < result['photos'].length; i++){
        String photoRef = photosResult[i]['photo_reference'];
        String picture = '$baseURL/photo?maxwidth=500&photoreference=$photoRef&key=$PLACES_API_KEY';
        print(picture);
        pictures.add(picture);
      }
    }
    
    SearchBar.searchResult = PlaceCoordinate(lat, lng, '', title, '', address, phone, website, openClosed, pictures);
    
    return Coordinate(lat, lng, '', title, '');
  }
}
