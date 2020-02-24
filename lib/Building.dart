import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';

//TODO: this building class is a temporary model of Building
class Building {
  String name;
  List<LatLng> boundary;

  Building(String name, List<LatLng> boundary) {
    this.name = name;
    this.boundary = boundary;
  }
}