// Displays a list of all the buildings

import 'package:flutter/material.dart';
import 'package:concordi_around/models/building.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 70,
        child: RaisedButton(
            child: Text("Building"), color: Colors.white, onPressed: () {}));
  }
}

class DisplayBuildingList extends State<DisplayBuildingListManager> {
  final List<Building> _myBuildingList = buildingList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Container(
            color: Colors.white,
            child: ListView.separated(
              itemCount: _myBuildingList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _myBuildingList[index].getName(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.name(_myBuildingList[index].getShortName());
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            )));
  }
}
