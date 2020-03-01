import 'dart:async';

import 'package:concordi_around/views/go_to_page.dart';
import 'package:concordi_around/widgets/drawer.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Geolocator _geolocator;
  Position _position;
  CameraPosition _cameraPosition;
  StreamSubscription _positionStream;

  @override
  Widget build(BuildContext context) {
    if (_cameraPosition == null) {
      _cameraPosition = CameraPosition(target: LatLng(0, 0));
    }

    return Scaffold(
        body: Stack(
          children: <Widget>[
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
              onCameraMove: (CameraPosition cameraPosition) async {},
            )),
            SearchBar(),
          ],
        ),
        drawer: SidebarDrawer(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: 'location',
                onPressed: () {
                  goToCurrent();
                },
                backgroundColor: Colors.white,
                foregroundColor: Color.fromRGBO(147, 0, 47, 1),
                tooltip: 'Get Location',
                child: Icon(Icons.my_location),
              ),
              SizedBox(
                height: 16,
              ),
              FloatingActionButton(
                heroTag: 'direction',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoToPage(
                        route: (List<String> temp) => {},
                      ),
                    ),
                  );
                },
                backgroundColor: Color.fromRGBO(147, 0, 47, 1),
                foregroundColor: Colors.white,
                child: Icon(Icons.directions),
              ),
            ]));
  }

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator()..forceAndroidLocationManager;
    LocationOptions locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
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

  void goToCurrent() async {
    final GoogleMapController controller = await _controller.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude), zoom: 19.03);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}
