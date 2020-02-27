import 'dart:async';
import 'package:concordi_around/mapNotifier.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:concordi_around/widgets/mapUI/svgFloorPlans.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'widgets/mapUI/FloorSelector.dart';
import 'package:concordi_around/globals' as globals;

void main() => runApp(ChangeNotifierProvider(
    builder: (context) => MapNotifier(), child: MyApp()));

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

    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    return MaterialApp(
        home: Scaffold(
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
                  initialCameraPosition: CameraPosition(
                      target: LatLng(49.497593, -55.578487),
                      zoom: 19.03557586669922),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _goToCurrent();
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    if (IsWithinHall(cameraPosition.target) &&
                        cameraPosition.zoom > 18) {
                      setState(() {
                        mapNotifier.setFloorSelectorVisibility(true);
                        //_goToHall8th();
                      });
                    } else {
                      mapNotifier.setFloorSelectorVisibility(false);
                    }
                  },
                )),
                SearchBar(name: (String building) => {_goToSelectedBuilding("$building")}),
                SVGFloorPlans(),
              ],
            ),
            drawer: SidebarDrawer(),
            resizeToAvoidBottomInset: false,
            floatingActionButton: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: FloorSelector(
                      selectedFloor: (int floor) => {
                          print("Clicked on floor $floor"),
                          mapNotifier.setSelectedFloor(floor)}
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: 'unique1',
                    onPressed: _goToCurrent,
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromRGBO(147, 0, 47, 1),
                    tooltip: 'Get Location',
                    child: Icon(Icons.my_location),
                  ),
                  SizedBox(height: 16,),
                  FloatingActionButton(
                    heroTag: 'unique2',
                    onPressed: () {},
                    backgroundColor: Color.fromRGBO(147, 0, 47, 1),
                    foregroundColor: Colors.white,
                    child: Icon(Icons.directions),
                  ),
                ])
                ));
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

  bool IsWithinHall(LatLng latLng) {
    
    List<LatLng> coordsList = [
      LatLng(45.49781, -73.57906),
      LatLng(45.49718, -73.57968),
      LatLng(45.49675, -73.57878),
      LatLng(45.49741, -73.57819)];

    return boundsFromLatLngList(coordsList)
        .contains(latLng);
  }

   LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  Future<void> _goToSelectedBuilding(String name) async {
    final GoogleMapController controller = await _controller.future;
    if (name.contains("Hall")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49726, -73.57895),
          zoom: 18.5);
      _goToHall8th();
    }
    else if (name.contains("Video")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49683, -73.57793),
          zoom: 18.5);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
    }
    else if (name.contains("John")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49531, -73.57901),
          zoom: 18.5);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
    }
    else if (name.contains("H806")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49715, -73.57878),
          zoom: 21);
       _goToHall8th();
    }
    else if (name.contains("H832")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49728, -73.57924),
          zoom: 21);
       _goToHall8th();
    }
    else if (name.contains("H860")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49744, -73.57875),
          zoom: 21);
       _goToHall8th();
    }
  }

  Future<void> _goToHall8th() async {
     setState(() {
                  enableGestures = false;
                });

    CameraPosition _currentPos = CameraPosition(bearing: 123.31752014160156, target: LatLng(45.49726709926478, -73.57894677668811), tilt: 0.0, zoom: 19.03557586669922);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(LatLng(45.49726709926478, -73.57894677668811)));
    controller.moveCamera(CameraUpdate.newLatLng(LatLng(45.49726709926478, -73.57894677668811)));
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));

  }
}
