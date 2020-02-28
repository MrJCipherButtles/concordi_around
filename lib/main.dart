import 'dart:async';
import 'package:concordi_around/provider/mapNotifier.dart';
import 'package:concordi_around/views/go_to_page.dart';
import 'package:concordi_around/widgets/floor_selector_enter_building_column.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:concordi_around/widgets/svg_floor_plans.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
  Geolocator _geolocator;
  Position _position;
  CameraPosition _cameraPosition;
  StreamSubscription _positionStream;

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator()..forceAndroidLocationManager;
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 1);
    updateLocation();
    _positionStream =
        _geolocator.getPositionStream(locationOptions).listen((Position pos) {
      setState(() {
        _position = pos;
        _cameraPosition = CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: 19.03);
      });
    });
  }

  @override
  void dispose() {
    if (_positionStream != null) {
      _positionStream.cancel();
    }
    super.dispose();
  }

  void updateLocation() async {
    try {
      final GoogleMapController controller = await _controller.future;
      Position position = await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 5));
      setState(() {
        _position = position;
        _cameraPosition = CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: 19.03);
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    } catch (e) {
      print('Error in updateLocation: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    if (_cameraPosition == null) {
      _cameraPosition = CameraPosition(target: LatLng(0, 0));
    }

    return MaterialApp(
        home: Scaffold(
            body: Stack(
              children: <Widget>[
                // Replace this container with your Map widget
                Container(
                    child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: false,
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  initialCameraPosition: _cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onCameraMove: (CameraPosition cameraPosition) async {
                    GoogleMapController _mapController = await _controller.future;
                    if (IsWithinHallStrictBound(cameraPosition.target) &&
                        cameraPosition.zoom > 18) {
                      mapNotifier.setFloorPlanVisibility(true);
                      _setStyle(_mapController);
                    } else {
                      mapNotifier.setFloorPlanVisibility(false);
                      _resetStyle(_mapController);
                    }
                    if (IsWithinHall(cameraPosition.target)) {
                      mapNotifier.setEnterBuildingVisibility(true);
                    } else {
                      mapNotifier.setEnterBuildingVisibility(false);
                    }
                  },
                )),
                SearchBar(
                    name: (String building) =>
                        {_goToSelectedBuilding("$building")}),
                SVGFloorPlans(),
                FloorSelectorEnterBuilding(
                  selectedFloor: (int floor) =>
                      {mapNotifier.setSelectedFloor(floor)},
                  enterBuildingPressed: () => _goToHall8th(),
                ),
              ],
            ),
            drawer: SidebarDrawer(),
            resizeToAvoidBottomInset: false,
            floatingActionButton: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: 'unique1',
                    onPressed: _goToCurrent,
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromRGBO(147, 0, 47, 1),
                    tooltip: 'Get Location',
                    child: Icon(Icons.my_location),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  FloatingActionButton(
                    heroTag: 'unique2',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoToPage(route: (List<String> temp) => {print("HIIIIIIIIIIIIIIIIIII"+ temp[0] + " " + temp[1])},),
                        ),
                      );
                    },
                    backgroundColor: Color.fromRGBO(147, 0, 47, 1),
                    foregroundColor: Colors.white,
                    child: Icon(Icons.directions),
                  ),
                ])));
  }

  Future<void> _goToCurrent() async {
    final GoogleMapController controller = await _controller.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude), zoom: 19.03);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  bool IsWithinHallStrictBound(LatLng latLng) {
    List<LatLng> coordsList = [LatLng(45.49726709926478, -73.57894677668811)];

    return boundsFromLatLngList(coordsList).contains(latLng);
  }

  bool IsWithinHall(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.49718, -73.57968),
      LatLng(45.49675, -73.57878),
      LatLng(45.49741, -73.57819),
      LatLng(45.49781, -73.57906)
    ];

    return boundsFromLatLngList(coordsList).contains(latLng);
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
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49726, -73.57895), zoom: 18.5);
      _goToHall8th();
    } else if (name.contains("Video")) {
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49683, -73.57793), zoom: 18.5);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
    } else if (name.contains("John")) {
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49531, -73.57901), zoom: 18.5);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
    } else if (name.contains("H806")) {
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49715, -73.57878), zoom: 21);
      _goToHall8th();
    } else if (name.contains("H832")) {
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49728, -73.57924), zoom: 21);
      _goToHall8th();
    } else if (name.contains("H860")) {
      CameraPosition _currentPos =
          CameraPosition(target: LatLng(45.49744, -73.57875), zoom: 21);
      _goToHall8th();
    }
  }

  Future<void> _goToHall8th() async {
    CameraPosition _currentPos = CameraPosition(
        bearing: 123.31752014160156,
        target: LatLng(45.49726709926478, -73.57894677668811),
        tilt: 0.0,
        zoom: 19.03557586669922);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }

  void _setStyle(GoogleMapController controller) async {
    print("Setting map style");
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  void _resetStyle(GoogleMapController controller) async {
    print("Reseting");
    String value = await DefaultAssetBundle.of(context).loadString('assets/map_style_reset.json');
    controller.setMapStyle(value);
  }
}
