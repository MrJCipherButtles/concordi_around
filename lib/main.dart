import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  static final CameraPosition _kGooglePlex = CameraPosition(
<<<<<<< refs/remotes/origin/master
    target: LatLng(45.4973, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
=======
    target: LatLng(45.49739, -73.57874),
    zoom: 25.0,
  );
>>>>>>> Add GoogleMaps Flutter SDK to both Android and iOS (#49)

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
<<<<<<< refs/remotes/origin/master
        indoorViewEnabled: true,
=======
>>>>>>> Add GoogleMaps Flutter SDK to both Android and iOS (#49)
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
<<<<<<< refs/remotes/origin/master
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
=======
        indoorViewEnabled: true,
>>>>>>> Add GoogleMaps Flutter SDK to both Android and iOS (#49)
      ),
    );
  }

<<<<<<< refs/remotes/origin/master
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
=======


}
>>>>>>> Add GoogleMaps Flutter SDK to both Android and iOS (#49)
