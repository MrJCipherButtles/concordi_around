import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/data/data_points.dart' as data;

class MarkerHelper {
  Set<Marker> eightfloorMarker = {};
  Set<Marker> ninthfloorMarker = {};
  Set<Marker> buildingMarker = {};
  BitmapDescriptor _roomIcon;
  BitmapDescriptor _maleIcon;
  BitmapDescriptor _femaleIcon;
  BitmapDescriptor _wheelchairIcon;
  BitmapDescriptor _stairsIcon;
  BitmapDescriptor _escalatorIcon;
  BitmapDescriptor _flagIcon;
  BitmapDescriptor _startIcon;
  BitmapDescriptor _evIcon;
  BitmapDescriptor _cbIcon;
  BitmapDescriptor _spIcon;
  BitmapDescriptor _cjIcon;
  BitmapDescriptor _pbIcon;
  BitmapDescriptor _fcIcon;
  BitmapDescriptor _vlIcon;
  BitmapDescriptor _hIcon;
  BitmapDescriptor _lbIcon;
  BitmapDescriptor _gmIcon;
  BitmapDescriptor _jmsbIcon;
  BitmapDescriptor _psbIcon;

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
    _evIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/EV.png');
    _cbIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/CB.png');
    _spIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/SP.png');
    _cjIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/CJ.png');
    _pbIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/PB.png');
    _fcIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/FC.png');
    _vlIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/VL.png');
    _hIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/H.png');
    _lbIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/LB.png');
    _gmIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/GM.png');
    _jmsbIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/JMSB.png');
    _psbIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/building_markers/PSB.png');
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
        markerId: MarkerId('destination'), icon: _flagIcon, position: latLng);
  }

  Set<Marker> getBuildingMarkers() {
    buildingMarker = {
      Marker(
        markerId: MarkerId('buildingMarker_EV'),
        icon: _evIcon,
        position: LatLng(45.495559, -73.578054),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_JMSB'),
        icon: _jmsbIcon,
        position: LatLng(45.495266, -73.578938),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_GM'),
        icon: _gmIcon,
        position: LatLng(45.495860, -73.578791),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_LB'),
        icon: _lbIcon,
        position: LatLng(45.496817, -73.577915),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_H'),
        icon: _hIcon,
        position: LatLng(45.497250, -73.578955),
      ),

      // LOYOLA

      Marker(
        markerId: MarkerId('buildingMarker_VL'),
        icon: _vlIcon,
        position: LatLng(45.458950, -73.638552),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_FC'),
        icon: _fcIcon,
        position: LatLng(45.4585971, -73.6405597),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_PB'),
        icon: _pbIcon,
        position: LatLng(45.458978, -73.640472),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_CJ'),
        icon: _cjIcon,
        position: LatLng(45.457457, -73.640378),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_SP'),
        icon: _spIcon,
        position: LatLng(45.457847, -73.641489),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_CB'),
        icon: _cbIcon,
        position: LatLng(45.458302, -73.640348),
      ),
      Marker(
        markerId: MarkerId('buildingMarker_PSB'),
        icon: _psbIcon,
        position: LatLng(45.4596546, -73.639771),
      ),
    };
    return buildingMarker;
  }
}
