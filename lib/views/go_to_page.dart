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
    FocusNode destinationTextField =
    new FocusNode(); // this focus node will be used for the second text field (destination)
    return Container(
      child: Material(
        child: Container(
          margin: new EdgeInsets.only(left: 15.0, top: MediaQuery.of(context).padding.top + 5.0, right: 15.0),
          //color: Color.fromRGBO(147, 0, 44, 1),
          padding: EdgeInsets.only(
            top: 10,
            right: 35,
            left: 20,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1, // This flex is for the icon
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(147, 0, 47, 1),
                        size: 25,
                      ),
                    ),
                  ),
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
                              EdgeInsets.fromLTRB(15.0, 12.0, 20.0, 15.0),
                          hintText: "origin...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        controller: this._originTypeAheadController,
                      ),
                      suggestionsCallback: (pattern) async {
                        var roomTitles = new List<String>();
                        //TODO: add room list here
                        for (var room in []) {
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
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.place,
                                color: Color.fromRGBO(147, 0, 47, 1)),
                            title: Text(suggestion),

                            //subtitle: Text('\$${suggestion['price']}'),
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this._originTypeAheadController.text = suggestion;
                        originDestination.add("$suggestion");
                        FocusScope.of(context).requestFocus(
                            destinationTextField); // to change the focus of the textfield to the second textfield
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
                        focusNode:
                            destinationTextField, //set the focus to the variable defined in definition of class
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
                        for (var room in []) {
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
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.place,
                                color: Color.fromRGBO(147, 0, 47, 1)),

                            title: Text(suggestion),
                            //subtitle: Text('\$${suggestion['price']}'),
                          ),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
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
