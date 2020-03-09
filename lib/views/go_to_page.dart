import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/widgets/sliding_up_panel.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

var roomsList = BuildingSingleton().getAllRooms();

class GoToPage extends StatefulWidget {
  final Function(List<Coordinate>) coordinates;
  GoToPage({@required this.coordinates});

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

  List<Coordinate> originDestinationCoords = new List(2);

  @override
  Widget build(BuildContext context) {
    FocusNode destinationTextField =
        new FocusNode(); // this focus node will be used for the second text field (destination)
    ShuttleTimes shuttleTimes =
        new ShuttleTimes(); // this will be used to find the next bus time
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        panel: Center(child: Text("This is the sliding Widget")),
        collapsed: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(147, 35, 57, 1),
          ),
          child: Center(
            child: Text(
              shuttleTimes.findNextShuttle(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Center(
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
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
                              hintText: "Choose starting location",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            controller: this._originTypeAheadController,
                          ),
                          suggestionsCallback: (pattern) async {
                            var roomTitles = new List<String>();
                            for (var room in roomsList) {
                              if (room.roomId.toUpperCase().startsWith(
                                  pattern.toString().toUpperCase())) {
                                roomTitles.add(room.roomId);
                              }
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
                            this._originTypeAheadController.text = suggestion;
                            FocusScope.of(context).requestFocus(
                                destinationTextField); // to change the focus of the textfield to the second textfield
                            for (RoomCoordinate room in roomsList) {
                              if (room.roomId == suggestion) {
                                originDestinationCoords[0] = room;
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 35),
                      Expanded(
                        flex: 1,
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
                              hintText: "Choose destination",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            controller: this._destinTypeAheadController,
                          ),
                          suggestionsCallback: (pattern) async {
                            var roomTitles = new List<String>();
                            var roomsList = new List<RoomCoordinate>();
                            roomsList = BuildingSingleton().getAllRooms();
                            for (var room in roomsList) {
                              if (room.roomId.toUpperCase().startsWith(
                                  pattern.toString().toUpperCase())) {
                                roomTitles.add(room.roomId);
                              }
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
                            FocusScope.of(context).requestFocus(
                                destinationTextField); // to change the focus of the textfield to the second textfield
                            for (RoomCoordinate room in roomsList) {
                              if (room.roomId == suggestion) {
                                originDestinationCoords[1] = room;
                              }
                            }
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
                        if (originDestinationCoords[0] != null &&
                            originDestinationCoords[1] != null &&
                            originDestinationCoords[0] !=
                                originDestinationCoords[1]) {
                          Navigator.pop(context);
                          widget.coordinates(originDestinationCoords);
                        }
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
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 30),
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

