import 'dart:async';
import 'package:concordi_around/db/DBAdapter.dart';
import 'package:concordi_around/db/model/floor.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'db/model/coordinate.dart';
import 'db/model/poi.dart';
import 'db/model/post.dart';

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

  final postBean = PostBean(_adapter);
  final coordinateBean = CoordinateBean(_adapter);
  final floorBean = FloorBean(_adapter);
  final poiBean = PoiBean(_adapter);

  int id1 = 3;

  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await coordinateBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await floorBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Create a coordinate table
  sb.writeln('Creating coordinate table ....');
  await poiBean.createTable(ifNotExists: true);
  sb.writeln('Created coordinate table ....');

  // Insert some coordinates
  //  sb.writeln('Inserting sample rows ...');
  //  int cid1 = await coordinateBean
  //      .insert(new Coordinate.make(1, 40.5, 50.9));
  //  sb.writeln('Inserted successfully row with id: $cid1!');

    sb.writeln('Inserting sample floor ...');
    int fid1 = await coordinateBean
        .insert(new Floor.make(1, 40.5, 50.9));
    sb.writeln('Inserted successfully row with id: $cid1!');

    sb.writeln('Inserting sample poi ...');
    int pid1 = await coordinateBean
        .insert(new Coordinate.make(1, 40.5, 50.9));
    sb.writeln('Inserted successfully row with id: $cid1!');

  // Find one post
  sb.writeln('Reading row with id $id1 ...');
  Post post1 = await postBean.find(id1);
  sb.writeln(post1);
  sb.writeln('--------------');

  // Find all posts
  sb.writeln('Reading all rows ...');
  List<Post> posts = await postBean.getAll();
  posts.forEach((p) => sb.writeln(p));
  sb.writeln('--------------');

  // Update a post
  sb.write('Updating a column in row with id $id1 ...');
  await postBean.updateReadField(id1, true);
  sb.writeln(' successful!');
  sb.writeln('--------------');


  // Find all posts
  sb.writeln('Reading all rows ...');
  posts = await postBean.getAll();
  posts.forEach((p) => sb.writeln(p));
  sb.writeln('--------------');


  sb.write('Closing the connection ...');
  await _adapter.close();
  sb.writeln(' successful!');
  sb.writeln('--------------');

  print(sb.toString());
  print(_adapter.version);
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