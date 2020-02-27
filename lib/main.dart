import 'dart:async';
import 'package:concordi_around/mapNotifier.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'widgets/mapUI/FloorSelector.dart';

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
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    updateLocation();
    _positionStream = _geolocator.getPositionStream(locationOptions).listen(
        (Position pos) {
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
      Position position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
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

    bool showFloorSelector = false;
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    if(_cameraPosition == null) {
      _cameraPosition = CameraPosition(
          target: LatLng(0, 0)
      );
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
                  onCameraMove: (CameraPosition cameraPosition) {
                    if (IsWithinHall(cameraPosition.target) &&
                        cameraPosition.zoom > 17) {
                      setState(() {
                        mapNotifier.setFloorSelectorVisibility(true);
                      });
                    } else {
                      mapNotifier.setFloorSelectorVisibility(false);
                    }
                  },
                )),
                SearchBar(name: (String building) => {print("HIIIIIIIIIIIII")}),
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
                      selectedFloor: (int val) =>
                          print("Clicked on index $val"),
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
    final GoogleMapController controller = await _controller.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: 19.03);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  bool IsWithinHall(LatLng latLng) {
    return LatLngBounds(
            southwest: LatLng(45.49607, -73.57869),
            northeast: LatLng(45.49894, -73.57934))
        .contains(latLng);
  }

  Future<void> _goToSelectedBuilding(String name) async {
    final GoogleMapController controller = await _controller.future;
    print("INNNNSDIDISISDDFBSHFG GOT TOSELECTED BUILDINNHHHH");
    if (name.contains("hall")) {
      CameraPosition _currentPos = CameraPosition(
          target: LatLng(45.49726, -73.57895),
          zoom: 18.5);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
    }
  }
}
