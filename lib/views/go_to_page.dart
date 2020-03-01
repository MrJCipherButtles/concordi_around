import 'package:concordi_around/models/coordinate.dart';
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
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(147, 0, 44, 0.65)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        controller: this._originTypeAheadController,
                      ),
                      suggestionsCallback: (pattern) async {
                        var roomTitles = new List<RoomCoordinate>();
                        //TODO: add room list here
                        for (var room in roomTitles) {
                          //TODO: fix this for loop

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
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(147, 0, 44, 0.65)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        controller: this._destinTypeAheadController,
                      ),
                      suggestionsCallback: (pattern) async {
                        //TODO: add room list here
                        var roomTitles = new List<RoomCoordinate>();
                        for (var roomID in roomTitles) {
                          //TODO: fix this for loop

                        }
                        return roomTitles;
                      },
                      itemBuilder: (context, suggestion) {
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: Icon(Icons.place,
                                color: Color.fromRGBO(147, 0, 47, 1)),
                            title: Text(suggestion),
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
              SizedBox(height: 20.0),
              Center(
                child: FloatingActionButton(
                  child: Icon(
                    Icons.navigation,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  backgroundColor: Color.fromRGBO(147, 0, 47, 1),
                  elevation: 2,
                  onPressed: () {
                    print("Start navigation button pressed");
                  },
                ),
              ),
              Text(
                "Go",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                  color: Color.fromRGBO(147, 0, 47, 1),
                ),
                textAlign: TextAlign.justify,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: Text('')),
                    Expanded(
                      flex: 10,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(147, 0, 47, 1))),
                        elevation: 2,
                        child: Align(
                          child: Text(
                            "ETA (min) + Distance (m/km)",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color.fromRGBO(147, 0, 47, 1),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO adding the recent places list
            ],
          ),
        ),
      ),
    );
  }
}
