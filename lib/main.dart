import 'dart:async';
import 'package:concordi_around/db/DBAdapter.dart';
import 'package:concordi_around/models/floor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'models/coordinate.dart';
import 'models/polygon.dart' as uma;


SqfliteAdapter _adapter;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var sb = StringBuffer();
  sb.writeln("Jaguar ORM showcase:");
  sb.writeln('--------------');
  sb.write('Connecting ...');
  DBAdapter dbAdapter = new DBAdapter();
  _adapter = await dbAdapter.getAdapter();
  sb.writeln(' successful!');
  sb.writeln('--------------');

  final floorBean = FloorBean(_adapter);
  final coordinateBean = CoordinateBean(_adapter);
  final polygonBean = new uma.PolygonBean(_adapter);

  await coordinateBean.drop();
  await floorBean.drop();
  await polygonBean.drop();
  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await coordinateBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await floorBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  await polygonBean.createTable(ifNotExists: true);

  Coordinate coordinate = new Coordinate(lat: 1.0, lng: 1.0, parentId: 4, adjCoordinates: [new Coordinate(lat: 2.0, lng: 2.0), new Coordinate(lat: 3.0, lng: 3.0), new Coordinate(lat: 4.0, lng: 4.0)]);

   Floor floor = new Floor(floor:"h831", coordinates: [new Coordinate(lat: 10.5, lng: 69.0, parentId: 4)],
   polygons: [new uma.Polygon(boundary:[new Coordinate(lat: 10.5, lng: 69.0, parentId: 4), new Coordinate(lat: 20.5, lng: 69.0, parentId: 4), new Coordinate(lat: 10.5, lng: 19.0, parentId: 4)] )]);
  sb.write('Before Insertion we got Floors');

  await floorBean.insert(floor, cascade: true);

  uma.Polygon poly = new uma.Polygon(boundary:[new Coordinate(lat: 10.5, lng: 69.0, parentId: 4), new Coordinate(lat: 20.5, lng: 69.0, parentId: 4), new Coordinate(lat: 10.5, lng: 19.0, parentId: 4)]);
  await polygonBean.insert(poly);

//  var cord = await coordinateBean.find(1, preload: true);
//  print(cord);
//  sb.write('-----------------------------------');

  var flo = await floorBean.find(1, preload: true);
  print(flo);
  sb.write('-----------------------------------');

  var pol = await polygonBean.find(1, preload: true);
  print(pol);
  sb.write('-----------------------------------');

  sb.write('Closing the connection ...');
  await _adapter.close();
  // sb.writeln(' successful!');
  // sb.writeln('--------------');

  // print(sb.toString());
  // print(_adapter.version);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Text("dw"),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

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