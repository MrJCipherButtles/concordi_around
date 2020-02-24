//import 'dart:html';

import 'package:concordi_around/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

// class PositionedFloatingSearchBar extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _PositionedFloatingSearchBarState();
//   }
// }

// class _PositionedFloatingSearchBarState
//     extends State<PositionedFloatingSearchBar> {

//       GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyAzsZ2URCqgDm9aJcduUyXVot5TEIANu6w");
//       bool isTyping = false;
//       String campus = "SGW";

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: MediaQuery.of(context).padding.top + 5.0,
//       right: 15,
//       left: 15,
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20), color: Colors.white),
//         child: Row(
//           children: <Widget>[
//             Container(
//               child: isTyping
//                   ? IconButton(
//                       splashColor: Colors.grey,
//                       icon: Icon(Icons.arrow_back),
//                       onPressed: () => Scaffold.of(context).openDrawer(),
//                     )
//                     :
//                     IconButton(
//                       splashColor: Colors.grey,
//                       icon: Icon(Icons.menu),
//                       onPressed: () => Scaffold.of(context).openDrawer(),
//                     ),
//             ),
//             Expanded(
//               child: TextField(
//                 cursorColor: Colors.black,
//                 keyboardType: TextInputType.text,
//                 textInputAction: TextInputAction.go,
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(horizontal: 15),
//                     hintText: "Search..."),
//                 onTap: (){

//                   // setState(() {
//                   //   isTyping = true;
//                   // });
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child:
//                 RaisedButton(
//                   child: Text(campus),
//                   textColor: Colors.white,
//                   color: Color.fromRGBO(147, 35, 57, 1),
//                   shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50)),
//                   onPressed: (){
//                     setState(() {
//                       // Use this at toggle text between SGW and Loyola
//                       // if(campus == "SGW")
//                       // campus = "LOY";
//                       // else
//                       // campus = "SGW";
//                     });
//                   },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   //Method for google prediction which we most likely wont use
//   Future<Null> displayPrediction(Prediction p) async {
//     if (p != null) {
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId);
//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;
//       var address = await Geocoder.local.findAddressesFromQuery(p.description);
//       print(lat);
//       print(lng);
//     }
//   }
// }

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //primary: false,
        backgroundColor: Color.fromRGBO(147, 0, 44, 30),

        title: Text("Serach..."),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: PositionedFloatingSearchBar());
            },
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class Room {
  String _name;
  double _longitude;
  double _latitude;
  Room(String name, double latitude, double longitude) {
    this._name = name;
    this._longitude = longitude;
    this._latitude = latitude;
  }
  String getName() {
    return this._name;
  }

  double getLatitude() {
    return this._latitude;
  }

  double getLongitude() {
    return this._longitude;
  }
}

class PositionedFloatingSearchBar extends SearchDelegate<String> {
  List<Room> rooms = [
    Room("H806", 45.49715, -73.57878),
    Room("H860", 45.49744, -73.57875),
    Room("EV202", 1, 1),
    Room("H937", 1, 1),
    Room("H866", 1, 1),
    Room("H809", 1, 1),
    Room("H810", 1, 1),
    Room("H811", 1, 1),
    Room("H922", 1, 1),
    Room("Reggies", 1, 1),
  ];
  final recentRooms = [
    Room("H806", 45.49715, -73.57878),
    Room("EV202", 1, 1),
  ];

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

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentRooms
        : rooms
            .where((p) => p.getName().startsWith(query.toUpperCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          //print(suggestionList[index].getName());
          Room selected = (suggestionList[index]);
          // var ms = new MapSampleState();
          
          // ms.goToCoordinate(selected.getLatitude(), selected.getLongitude());
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapSample())
          );
          
          
        },
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index].getName()),
      ),
      itemCount: suggestionList.length,
    );
  }
}
