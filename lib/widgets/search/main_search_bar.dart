import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/widgets/search/search_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:concordi_around/services/constants.dart' as constants;

String campus = 'SGW';

class SearchBar extends StatefulWidget {
  final Function(Coordinate) coordinate;
  SearchBar({this.coordinate});

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
              borderRadius: BorderRadius.circular(constants.BORDER_RADIUS),
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
                  child: Text(campus),
                  textColor: Colors.white,
                  color: constants.COLOR_CONCORDIA,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          new BorderRadius.circular(constants.BORDER_RADIUS)),
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
  final Function(Coordinate) coordinate;
  PositionedFloatingSearchBar({this.coordinate});

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
        ? SearchMenuListOption(
            coordinate: (Coordinate coordinate) =>
                {this.coordinate(coordinate)})
        : ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                RoomCoordinate selected = (suggestionList[index]);
                Navigator.pop(context);
                this.coordinate(selected);
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
