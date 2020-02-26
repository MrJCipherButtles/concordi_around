// Displays a list of all the buildings

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import './building.dart';

class DisplayBuildingListManager extends StatefulWidget {

  final Function(String) name;

  DisplayBuildingListManager({this.name});

  @override
  State<StatefulWidget> createState() {
    return DisplayBuildingList();
  }
}

class BuildingManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildingManagerState();
  }
}

class _BuildingManagerState extends State<BuildingManager> {
  //bool _listVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: RaisedButton(
            child: Text("Building"),
            color: Colors.white,
            onPressed: () {
            }));
  }
}

class DisplayBuildingList extends State<DisplayBuildingListManager> {
  final List<Building> _myBuildingList = new List<Building>();

  @override
  Widget build(BuildContext context) {
    _createBuildingList();
    return Expanded(
        flex: 8,
        child: Container(
            color: Colors.white,
            child: ListView.separated(
              itemCount: _myBuildingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_myBuildingList[index].toString(),),
                  onTap: () {
                    widget.name(_myBuildingList[index].getbuildingName());
                                        
                    },  
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              )
            ));
  }

  void _createBuildingList() {
    _myBuildingList.clear();
    _myBuildingList
        .add(new Building("Henry F. Hall", "H", "none", "1455", "Maisonneuve"));
    _myBuildingList.add(new Building(
        "Engineering and Video", "EV", "none", "1495-1505", "Guy"));
    _myBuildingList.add(new Building(
        "John Molson School of Business", "MB", "none", "1495-1505", "Guy"));
  }
}
