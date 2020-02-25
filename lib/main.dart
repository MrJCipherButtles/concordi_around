import 'dart:async';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:concordi_around/widgets/mapUI/indexedStackVisiblity.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:concordi_around/globals' as globals;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(0, 0),
    );
  }
}

class MapSample extends StatefulWidget {
  double lat;
  double lng;
  MapSample(double lat, double lng) {
    this.lat = lat;
    this.lng = lng;
  }

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  bool enableGestures = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
              child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            compassEnabled: true,
            indoorViewEnabled: true,
            scrollGesturesEnabled: enableGestures,
            rotateGesturesEnabled: enableGestures,
            tiltGesturesEnabled: enableGestures,
            zoomGesturesEnabled: enableGestures,
            initialCameraPosition:
                CameraPosition(target: LatLng(49.497593, -55.578487), zoom: 19.03557586669922),
            //CameraPosition(target: _initialPosition, zoom:18.5),
            //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition cameraPosition) {
              if (IsWithinHall(cameraPosition.target) &&
                  cameraPosition.zoom > 25) {
                _goToHall8th();
              }
            },
          )),
          IndexedStackVisibility(),
          Container(
            //height: 80,
            //width: double.infinity,
            child: SearchBar(),
          ),
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

  Future<void> _goToCurrent() async {
    if (enableGestures) {
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

  Future<void> goToCoordinate(double lat, double long) async {
    if (enableGestures) {
      final Geolocator geolocator = Geolocator()
        ..placemarkFromCoordinates(lat, long);

      // var currentLocation = await geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.best);

      CameraPosition _pointPos =
          CameraPosition(target: LatLng(lat, long), zoom: 19.03557586669922);

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_pointPos));
      //final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_pointPos));
    }
  }
  ////

  Future<void> _goToHall8th() async {
    globals.showMap = true;
    setState(() {
      enableGestures = false;
    });

    CameraPosition _currentPos = CameraPosition(
        bearing: 123.31752014160156,
        target: LatLng(45.49726709926478, -73.57894677668811),
        tilt: 0.0,
        zoom: 19.03557586669922);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(45.49726709926478, -73.57894677668811)));
    controller.moveCamera(
        CameraUpdate.newLatLng(LatLng(45.49726709926478, -73.57894677668811)));
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }

  bool IsWithinHall(LatLng latLng) {
    return LatLngBounds(
            southwest: LatLng(45.4967, -73.57885),
            northeast: LatLng(45.49789, -73.57907))
        .contains(latLng);
  }
}
