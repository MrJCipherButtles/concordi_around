import 'package:concordi_around/models/building.dart';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DisplayBuildingListManager extends StatefulWidget {
  final Function(LatLng) latlng;

  DisplayBuildingListManager({this.latlng});

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
  final List<Building> _myBuildingList = BuildingSingleton().buildings;

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
                    _myBuildingList[index].building,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.latlng(_myBuildingList[index].coordinate.toLatLng());
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            )));
  }
}
