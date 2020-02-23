// Displays a list of all the buildings

import 'package:flutter/material.dart';

import './building.dart';

class BuildingManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BuildingManagerState();
  }
}

class _BuildingManagerState extends State<BuildingManager> {
  List<Building> _myBuildingList = new List<Building>();

  bool _listVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: () {
              setState(() {
                _listVisible = (_listVisible ? false : true);
              });
            }),
            _listVisible ? _DisplayList() : Container(color: Colors.cyan),
          ],
        ));
  }

  List<Building> _createBuildingList() {
    _myBuildingList
        .add(new Building("Henry F. Hall", "H", "none", "1455", "Maisonneuve"));
    _myBuildingList.add(
        new Building("Engineering and Video", "V", "none", "1495-1505", "Guy"));
  }

  List<Building> getBuildingList(){
    return _myBuildingList;
  }
}

class _DisplayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  ListView(children: <Widget>[Text("Item 1"), Text("Item 2")])),
        ]);
  }
}
