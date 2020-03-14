import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/data/data_points.dart' as data;

class MarkerHelper {
  Set<Marker> eightfloorMarker = {};
  Set<Marker> ninthfloorMarker = {};

  BitmapDescriptor _roomIcon;
  BitmapDescriptor _maleIcon;
  BitmapDescriptor femaleIcon;
  BitmapDescriptor wheelchairIcon;
  BitmapDescriptor stairsIcon;
  BitmapDescriptor escalatorIcon;

  MarkerHelper() {
    _initIcons();
  }

  _initIcons() async {
    _roomIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/class_icon.png');
    _maleIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/icon/male_icon.png');
    femaleIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/female_icon.png');
    wheelchairIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/wheelchair_icon.png');
    escalatorIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/escalator_icon.png');
    stairsIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/icon/stairs_icon.png');
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
        icon = femaleIcon;
      } else if (roomName.contains('EL')) {
        icon = wheelchairIcon;
      } else if (roomName.contains('STAIRS')) {
        icon = stairsIcon;
      } else if (roomName.contains('ESC')) {
        icon = escalatorIcon;
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
}
