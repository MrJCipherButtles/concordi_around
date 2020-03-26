import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/data/data_points.dart' as data;

class MarkerHelper {
  Set<Marker> eightfloorMarker = {};
  Set<Marker> ninthfloorMarker = {};

  BitmapDescriptor _roomIcon;
  BitmapDescriptor _maleIcon;
  BitmapDescriptor _femaleIcon;
  BitmapDescriptor _wheelchairIcon;
  BitmapDescriptor _stairsIcon;
  BitmapDescriptor _escalatorIcon;
  BitmapDescriptor _flagIcon;
  BitmapDescriptor _startIcon;

  MarkerHelper() {
    _initIcons();
  }

  _initIcons() async {
    _roomIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/class_icon.png');
    _maleIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/male_icon.png');
    _femaleIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/female_icon.png');
    _wheelchairIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/wheelchair_icon.png');
    _escalatorIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/escalator_icon.png');
    _stairsIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/stairs_icon.png');
    _flagIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/flag_icon.png');
    _startIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/start_icon.png');
    _setMarkers(8);
    _setMarkers(9);
  }

  void _setMarkers(int floorNumber) {
    for (RoomCoordinate room in data.floorMarkers['$floorNumber']) {
      BitmapDescriptor icon;

      String roomName = room.roomId;

      if (roomName == 'MW') {
        icon = _maleIcon;
      } else if (roomName == 'WW') {
        icon = _femaleIcon;
      } else if (roomName.contains('EL')) {
        icon = _wheelchairIcon;
      } else if (roomName.contains('STAIRS')) {
        icon = _stairsIcon;
      } else if (roomName.contains('ESC')) {
        icon = _escalatorIcon;
      } else {
        icon = _roomIcon;
      }

      if (floorNumber == 8) {
        eightfloorMarker.add(Marker(
            markerId: MarkerId(room.roomId),
            icon: icon,
            infoWindow: InfoWindow(title: room.roomId),
            position: room.toLatLng()));
      } else if (floorNumber == 9) {
        ninthfloorMarker.add(Marker(
            markerId: MarkerId(room.roomId),
            icon: icon,
            infoWindow: InfoWindow(title: room.roomId),
            position: room.toLatLng()));
      }
    }
  }

  Set<Marker> getFloorMarkers(int selectedFloor) {
    return selectedFloor == 8 ? eightfloorMarker : ninthfloorMarker;
  }

  void setStartEndMarker(RoomCoordinate start, RoomCoordinate end) {
    Marker startMarker = Marker(
        markerId: MarkerId('start'),
        icon: _startIcon,
        infoWindow: InfoWindow(title: start.roomId),
        position: start.toLatLng());

    Marker endMarker = Marker(
        markerId: MarkerId('end'),
        icon: _flagIcon,
        infoWindow: InfoWindow(title: end.roomId),
        position: end.toLatLng());

    removeStartEndMarker();
    end.floor == '8'
        ? eightfloorMarker.add(endMarker)
        : ninthfloorMarker.add(endMarker);
    start.floor == '8'
        ? eightfloorMarker.add(startMarker)
        : ninthfloorMarker.add(startMarker);
  }

  void removeStartEndMarker() {
    ninthfloorMarker.removeWhere((marker) =>
        marker.markerId.value == 'start' || marker.markerId.value == 'end');
    eightfloorMarker.removeWhere((marker) =>
        marker.markerId.value == 'start' || marker.markerId.value == 'end');
  }

  Marker getDestinationMarker(LatLng latLng) {
    return Marker(
        markerId: MarkerId('destination'),
        icon: _flagIcon,
        position: latLng);
  }
}
