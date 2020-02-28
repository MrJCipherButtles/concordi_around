import 'package:concordi_around/models/database.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class GoToPage extends StatefulWidget {
  
  final Function(List<String>) route;
  GoToPage({this.route});

  @override
  _GoToPageState createState() => new _GoToPageState();
  final originField = TextField(
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(15.0, 12.0, 10.0, 12.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );
}

class _GoToPageState extends State<GoToPage> {
  //To be able to save the selected suggestion into the text field
  final TextEditingController _originTypeAheadController =
      TextEditingController();
  final TextEditingController _destinTypeAheadController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    List<String> originDestination = [];

    return Container(
      child: Material(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 35,
            left: 20,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1, // This flex is for the icon
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 12.0, 20.0, 15.0),
                          hintText: "origin...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        controller: this._originTypeAheadController,
                      ),
                      suggestionsCallback: (pattern) async {
                        var roomTitles = new List<String>();
                        for (var room in rooms) {
                          if (room
                              .getTitle()
                              .toUpperCase()
                              .startsWith(pattern.toString().toUpperCase())) {
                            roomTitles.add(room.getTitle());
                          }
                        }
                        return roomTitles; //await BackendService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.place,
                              color: Color.fromRGBO(147, 0, 47, 1)),
                          title: Text(suggestion),
                          //subtitle: Text('\$${suggestion['price']}'),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this._originTypeAheadController.text = suggestion;
                        originDestination.add("$suggestion");
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Text('')),
                  Expanded(
                    flex: 10,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 12.0, 10.0, 12.0),
                          hintText: "destination...",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        controller: this._destinTypeAheadController,
                      ),
                      suggestionsCallback: (pattern) async {
                        var roomTitles = new List<String>();
                        for (var room in rooms) {
                          if (room
                              .getTitle()
                              .toUpperCase()
                              .startsWith(pattern.toString().toUpperCase())) {
                            roomTitles.add(room.getTitle());
                          }
                        }
                        return roomTitles; //await BackendService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.place,
                              color: Color.fromRGBO(147, 0, 47, 1)),

                          title: Text(suggestion),
                          //subtitle: Text('\$${suggestion['price']}'),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        //Navigator.pop(context);
                        this._destinTypeAheadController.text = suggestion;
                        originDestination.add("$suggestion");
                        widget.route(originDestination);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
