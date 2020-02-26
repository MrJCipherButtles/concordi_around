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

  int id1 = 3;

  await coordinateBean.drop();
  await floorBean.drop();
  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await coordinateBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await floorBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Insert some coordinates
  //  sb.writeln('Inserting sample rows ...');
  //  int cid1 = await coordinateBean
  //      .insert(new Coordinate.make(1, 40.5, 50.9));
  //  sb.writeln('Inserted successfully row with id: $cid1!');


  List<Coordinate> coordinates;
  Coordinate coordinate = new Coordinate(id:1, lat: 1.0, lng: 1.0, parentId: 4, adjCoordinates: [new Coordinate(id:7, lat: 2.0, lng: 2.0), new Coordinate(id:8, lat: 3.0, lng: 3.0), new Coordinate(id:11, lat: 4.0, lng: 4.0)]);

  // Floor floor = new Floor(floor:"h831", coordinates: [new Coordinate(id:7, lat: 10.5, lng: 69.0, parentId: 4), new Coordinate(id:8, lat: 42.5, lng: 69.0, parentId: 4), new Coordinate(id:11, lat: 83.5, lng: 49.0, parentId: 5)]);
  // Floor floor = new Floor(floor:"h831", coordinates: coordinates);
  sb.write('Before Insertion we got Floors');

  coordinates = coordinate.adjCoordinates;
  print(coordinate);

  // int id5 = await floorBean.insert(floor, cascade: true);
int id5 = await coordinateBean.insert(coordinate, cascade: true);


  sb.write('Inserted Floor with ID $id5');

  var floors = await coordinateBean.find(1.0, 1.0, preload: true);
  print(floors);
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