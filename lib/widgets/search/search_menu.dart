import 'package:concordi_around/widgets/search/building_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchMenuListOption extends StatelessWidget {

  final Function(LatLng) latlng;

  SearchMenuListOption({this.latlng});

  @override
  Widget build(BuildContext context) {
    return Container(
      //flex: 2,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),)
      ]),
      SizedBox(height: 5),
      DisplayBuildingListManager(
        latlng: (LatLng building) => {
          latlng(building)},
      ),
        ]));
  }
}
