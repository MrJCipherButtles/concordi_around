import 'dart:async';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:concordi_around/globals' as globals;
import 'widgets/mapUI/FloorSelector.dart';

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
  bool enableGestures = true;

  @override
  Widget build(BuildContext context) {

    bool showFloorSelector = false;
    
    return MaterialApp(
      home :Scaffold(
      body: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(
              child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: false,
            compassEnabled: false,
            indoorViewEnabled: false,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition:
                CameraPosition(target: LatLng(45.497593, -73.578487)),
            //CameraPosition(target: _initialPosition, zoom:18.5),
            //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _goToCurrent();
            },
            onCameraMove: (CameraPosition cameraPosition){
              if(IsWithinHall(cameraPosition.target) && cameraPosition.zoom > 16){
                setState(() {
                  FloorSelector().createState();
                  showFloorSelector = true;
                  print("Inside hall $showFloorSelector");
                });
              }
            },
          )),
          PositionedFloatingSearchBar(),
          FloorSelector(
            showFloorSelector: showFloorSelector,
            selectedFloor: (int val) => print("Clicked on index $val"),
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
    )
    );
  }

  Future<void> _goToCurrent() async {
    if(enableGestures){
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

  bool IsWithinHall(LatLng latLng){
    return LatLngBounds(southwest: LatLng(45.49607, -73.57869), northeast: LatLng(45.49894, -73.57934)).contains(latLng);
  }
}
