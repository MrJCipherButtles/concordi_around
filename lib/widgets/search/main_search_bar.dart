import 'package:concordi_around/models/database.dart';
import 'package:concordi_around/widgets/search/search_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

String campus = "SGW";

class SearchBar extends StatefulWidget {

  final Function(String) name;

  SearchBar({this.name});

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Container(
        margin: new EdgeInsets.only(left: 15.0, top: MediaQuery.of(context).padding.top + 5.0, right: 15.0),
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
                
                onTap: (){
                  showSearch(
                      context: context,
                      delegate: PositionedFloatingSearchBar(name: (String building) => {widget.name(building)}));
                  
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
              )],
          ),
        ),
      ),
    ]);
  }
}

class PositionedFloatingSearchBar extends SearchDelegate<String> {

final Function(String) name;
PositionedFloatingSearchBar({this.name});

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
    final suggestionList = query.isNotEmpty
        ? recentSearchedRooms
        : rooms
            .where((p) => p.getTitle().startsWith(query.toUpperCase()))
            .toList();
    return query.isEmpty ? SearchMenuListOption(
      name: (String building) => {
        name(building),
      },) : ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          
          Coordinate selected = (suggestionList[index]);
          Navigator.pop(context);
          name(selected.getTitle());
        },
        leading: Icon(Icons.place),
        title: Text(suggestionList[index].getTitle()),
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
