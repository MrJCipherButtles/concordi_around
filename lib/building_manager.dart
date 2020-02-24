// Displays a list of all the buildings

import 'package:flutter/material.dart';

import './building.dart';

class _DisplayListManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DisplayList();
  }
}

class BuildingManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildingManagerState();
  }
}

class _BuildingManagerState extends State<BuildingManager> {

  bool _listVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RaisedButton(onPressed: () {
              setState(() {
                _listVisible = (_listVisible ? false : true);
              });
            }),
            _listVisible ? _DisplayListManager() : Container(color: Colors.cyan),
          ],
        )
      );
  }
}


class _DisplayList extends State<_DisplayListManager> {
  final List<Building> _myBuildingList = new List<Building>();
 
  @override
  Widget build(BuildContext context) {
    _createBuildingList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            constraints: BoxConstraints(
                maxHeight: 200, maxWidth: 100, minHeight: 150, minWidth: 100),
            color: Colors.green,
            child:
                ListView(children: <Widget>[Text(_myBuildingList[0].toString()), Text("Item 2")])),
        ]
      );
  }

  void _createBuildingList() {
    _myBuildingList.clear();
    _myBuildingList.add(
        new Building("Henry F. Hall", "H", "none", "1455", "Maisonneuve"));
    _myBuildingList.add(
        new Building("Engineering and Video", "EV", "none", "1495-1505", "Guy"));
  
  }

  List<Building> getBuildingList(){
    print(_myBuildingList[0].toString());
    return _myBuildingList;
  }
}
