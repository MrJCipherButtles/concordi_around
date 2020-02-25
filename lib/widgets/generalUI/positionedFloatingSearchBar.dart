import 'package:concordi_around/searchMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:concordi_around/database/database.dart";

bool isTyping = true;
String campus = "SGW";

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }
}

class _SearchBarState extends State<SearchBar> {

  bool isTyping = false;
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
                child: isTyping
                    ? IconButton(
                        splashColor: Colors.grey,
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isTyping = false;
                          });
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
                onChanged: (String text) {
                  setState(() {
                    isTyping = false;
                  });
                  // showSearch(
                  //     context: context,
                  //     delegate: PositionedFloatingSearchBar());
                },
                onTap: (){
                  setState(() {
                    isTyping= true;
                  });
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
                onPressed: () {},
              ),
              )],
          ),
        ),
      ),
      isTyping ? SearchMenuListOption() : Container(),
    ]);
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
          Navigator.pop(context);
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
