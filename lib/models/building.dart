// Created by Chester Yu
// Created: 20/02/2020
// Last Modified: 20/02/2020
// Class to create building object

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Building{

  String _name;
  String _shortName;
  String _campus;
  LatLng _latLng;

  Building(String name, String shortName, String campus, LatLng latLng){
    _name = name;
    _shortName = shortName;
    _campus = campus;
    _latLng = latLng;
  }

  String getName() {
    return _name;
  }

  String getShortName() {
    return _shortName;
  }

  String getCampus() {
    return _campus;
  }

  LatLng getLatLng() {
    return _latLng;
  }
}

final List<Building> buildingList = [
  Building("Henry F. Hall", "Hall", "SGW", LatLng(45.49726, -73.57893)), 
  Building("Engineering, Computer Science and Visual Arts", "EV", "SGW", LatLng(45.49558, -73.57801)), 
  Building("John Molson School of Business", "JMSB", "SGW", LatLng(45.4954, -73.57909)), 
  Building("Pavillon Guy-De Maisonneuve", "GM", "SGW", LatLng(45.49589, -73.5785)), 
];
