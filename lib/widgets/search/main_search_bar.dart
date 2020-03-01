import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/widgets/search/search_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String campus = 'SGW';

class SearchBar extends StatefulWidget {
  final Function(LatLng) latlng;
  SearchBar({this.latlng});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: new EdgeInsets.only(
            left: 15.0,
            top: MediaQuery.of(context).padding.top + 5.0,
            right: 15.0),
        padding: EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                            latlng: (LatLng latlng) =>
                                {widget.latlng(latlng)}));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: RaisedButton(
                  child: Text(campus),
                  textColor: Colors.white,
                  color: Color.fromRGBO(147, 35, 57, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50)),
                  onPressed: () {
                    setState(() {
                      (campus == 'SGW') ? (campus = 'LOY') : (campus = 'SGW');
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

class PositionedFloatingSearchBar extends SearchDelegate<String> {
  final Function(LatLng) latlng;
  PositionedFloatingSearchBar({this.latlng});

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
  Widget buildSuggestions(BuildContext context) {
    List<RoomCoordinate> roomList = BuildingSingleton().getAllRooms();
    List<RoomCoordinate> suggestionList = query.isNotEmpty
        ? roomList
            .where((p) => p.roomId.startsWith(query.toUpperCase()))
            .toList()
        : <RoomCoordinate>[];
    return query.isEmpty
        ? SearchMenuListOption(latlng: (LatLng latlng) => {this.latlng(latlng)})
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                RoomCoordinate selected = (suggestionList[index]);
                Navigator.pop(context);
                this.latlng(selected.toLatLng());
              },
              leading: Icon(Icons.place),
              title: Text(suggestionList[index].roomId),
            ),
            itemCount: suggestionList.length,
          );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }
}
