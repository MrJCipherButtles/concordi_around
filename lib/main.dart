import 'dart:async';
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
  Set<Marker> markers;
  bool isTapped = false;
  // static LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
  }
  //   _getUserLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(target: LatLng(45.497593, -73.578487), zoom: 19.5), 
        markers: markers,
        onTap: (pos) {
          Marker marker = Marker(markerId: MarkerId('marker'), position: pos);
          setState(() {
            markers.add(marker);
          });
        },
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
    LatLng currentCoordinates = LatLng(currentLocation.latitude, currentLocation.longitude);

    CameraPosition _currentPos = CameraPosition(
      target: currentCoordinates,
      zoom: 18.5);  

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));

    Marker marker = Marker(
      markerId: MarkerId('marker'), 
      position: currentCoordinates
      );
      setState(() {
        markers.add(marker);
      });
  }
}