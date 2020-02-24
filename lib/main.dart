import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'Building.dart';
import 'BuildingLatLngCollector.dart';
import 'BuildingLayer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Completer<Set<Polygon>> _polygons = Completer();
  // static LatLng _initialPosition;

  // @override
  // void initState() {
  //   super.initState();
  //   _getUserLocation();
  // }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        initialCameraPosition: CameraPosition(target: LatLng(45.497593, -73.578487)),
        polygons: getPolyList(),
        //CameraPosition(target: _initialPosition, zoom:18.5),
        //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrent,
        tooltip: 'Get Location',
        child: Icon(Icons.location_on),
      ),
    );
  }

  // void _getUserLocation() async {
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     _initialPosition = LatLng(position.latitude, position.longitude);
  //   });
  // }

  Set<Polygon> getPolyList()  {
    Set<Polygon> polygons = new Set();
    BuildingLatLngCollector buildingLatLngCollector = BuildingLatLngCollector();
    List<Building> buildings = buildingLatLngCollector.getLatLngConfigString(BuildingLayer.xml);
    for(Building building in buildings) {
      Polygon polygon = Polygon(
          polygonId: PolygonId(building.name),
          points: building.boundary,
          strokeColor: Colors.transparent,
          strokeWidth: 0,
          fillColor: Color.fromRGBO(147, 35, 57, 0.5)
      );
      polygons.add(polygon);
    }
    return polygons;
  }

  Future<void> _goToCurrent() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    var currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    CameraPosition _currentPos = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 18.5);  

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }

}