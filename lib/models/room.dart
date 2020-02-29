// Created by Chester Yu
// Created: 20/02/2020
// Last Modified: 20/02/2020
// Class to create building object

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Room{

  String _number;
  LatLng _latLng;
  int _floor;
  String _campus;


  Room(String roomNumber, LatLng latLng, int floor, String campus){
    _number = roomNumber;
    _latLng = latLng;
    _floor = floor;
    _campus = campus;
  }

  String toString(){
    return (_number);
  }

  String getRoomNumber(){
    return _number;
  }

  LatLng getLatLng(){
    return _latLng;
  }

  int getFloor(){
    return _floor;
  }

  String getCampus(){
    return _campus;
  }
}

final List<Room> roomsList = [
  Room("H806", LatLng(45.49715, -73.57878), 8, "SGW"),
  Room("H832", LatLng(45.49728, -73.57924), 8, "SGW"),
  Room("H860", LatLng(45.49744, -73.57875), 8, "SGW"),
  Room("H857", LatLng(45.49744, -73.57875), 8, "SGW"), // Change coordinate to real one
  Room("H859", LatLng(45.49744, -73.57875), 8, "SGW"), // Change coordinate to real one
  Room("H859", LatLng(45.49744, -73.57875), 8, "SGW"), // Change coordinate to real one
  Room("H823", LatLng(45.49744, -73.57875), 8, "SGW"), // Change coordinate to real one
  Room("H832", LatLng(45.49744, -73.57875), 8, "SGW"), // Change coordinate to real one
];

final List<Room> recentRoomsList = [
  Room("H806", LatLng(45.49715, -73.57878), 8, "SGW"),
  Room("H832", LatLng(45.49728, -73.57924), 8, "SGW"),
];