//import 'dart:html';

import 'package:concordi_around/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import "package:concordi_around/database/database.dart";

bool isTyping = true;
String campus = "SGW";
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5.0,
      right: 15,
      left: 15,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          children: <Widget>[
            Container(
              child: isTyping
                  ? IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: PositionedFloatingSearchBar());
                        // }=> Scaffold.of(context).openDrawer(),
                      },
                    )
                  : IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: PositionedFloatingSearchBar());
                },
              ),
            ),
           Padding(
              padding: const EdgeInsets.only(right: 8.0),
               child:
                RaisedButton(
                  child: Text(campus),
                  textColor: Colors.white,
                  color: Color.fromRGBO(147, 35, 57, 1),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50)),
                  onPressed: (){
                  //   setState(() {
                  //    //Use this at toggle text between SGW and Loyola
                  //    if(campus == "SGW")
                  //    campus = "LOY";
                  //    else
                  //    campus = "SGW";
                  //   },
                  //   );
                  },
              ),
            ),
          ],
          //drawer: Drawer(),
        ),
      ),
    );
  }
}

class PositionedFloatingSearchBar extends SearchDelegate<String> {
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
        ? recentSearchedRooms
        : rooms
            .where((p) => p.getTitle().startsWith(query.toUpperCase()))
            .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          //print(suggestionList[index].getTitke());
          Coordinate selected = (suggestionList[index]);
          //var ms = new MapSampleState();
          //ms.goToCoordinate(selected.getLatitude(), selected.getLongitude());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MapSample(selected.getLatitude(), selected.getLongitude()),
            ),
          );
        },
        leading: Icon(Icons.location_city),
        title: Text(suggestionList[index].getTitle()),
      ),
      itemCount: suggestionList.length,
    );
  }
}
