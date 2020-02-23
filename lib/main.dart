import 'dart:async';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

  // static LatLng _initialPosition;

  // @override
  // void initState() {
  //   super.initState();
  //   _getUserLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
              child: GoogleMap(
            mapType: MapType.normal,
            indoorViewEnabled: true,
            initialCameraPosition:
                CameraPosition(target: LatLng(45.497593, -73.578487)),
            //CameraPosition(target: _initialPosition, zoom:18.5),
            //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          )),
          PositionedFloatingSearchBar()
        ],
      ),
      drawer: SidebarDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCurrent,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        tooltip: 'Get Location',
        child: Icon(Icons.my_location),
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

    var currentLocation = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    CameraPosition _currentPos = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 18.5);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }
}
