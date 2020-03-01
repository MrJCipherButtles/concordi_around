import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'building_manager.dart';

class SearchMenuListOption extends StatelessWidget {

  final Function(LatLng) latlng;

  SearchMenuListOption({this.latlng});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
      DisplayBuildingListManager(
        latlng: (LatLng latlng) => {
          this.latlng(latlng)},
      ),
        ]));
  }
}
