import 'dart:async';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/data/data_points.dart';
import 'package:concordi_around/models/building.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/models/path.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/services/map_helper.dart';
import 'package:concordi_around/views/go_to_page.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:concordi_around/widgets/svg_floor_plan/floor_selector_enter_building_column.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:concordi_around/services/constants.dart' as constants;
import 'package:concordi_around/global.dart' as globals;

class Map extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _completer;
  Geolocator _geolocator;
  Position _position;
  CameraPosition _cameraPosition;
  StreamSubscription _positionStream;

  Set<Polyline> direction;

  Set<Polygon> buildingHighlights;

  Set<Polygon> eightFloorPolygon;
  Set<Marker> eightFloorMarker = {};

  Set<Polygon> ninthFloorPolygon;
  Set<Marker> ninthFloorMarker = {};

  var shortestPath;

  @override
  void initState() {
    super.initState();
    buildingHighlights = BuildingSingleton().getOutdoorBuildingHighlights();
    eightFloorPolygon = BuildingSingleton().getFloorPolygon('hall', '8');
    ninthFloorPolygon = BuildingSingleton().getFloorPolygon('hall', '9');

    buildingHighlights.addAll(ninthFloorPolygon);

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
            zoom: constants.CAMERA_DEFAULT_ZOOM);
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
      final GoogleMapController controller = await _completer.future;
      Position position = await _geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .timeout(new Duration(seconds: 5));
      setState(() {
        _position = position;
        _cameraPosition = CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: constants.CAMERA_DEFAULT_ZOOM);
      });
      controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    } catch (e) {
      print('Error in updateLocation: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);
    _completer = Provider.of<MapNotifier>(context, listen: false).getCompleter;

    if (_cameraPosition == null) {
      _cameraPosition = CameraPosition(target: LatLng(0, 0));
    }

    return Stack(
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
          polygons: buildingHighlights,
          polylines: direction,
          markers: eightFloorMarker,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          onCameraMove: (CameraPosition cameraPosition) async {
            GoogleMapController _mapController = await _completer.future;
            if (MapHelper.isWithinHallStrictBound(cameraPosition.target) &&
                cameraPosition.zoom > constants.CAMERA_DEFAULT_ZOOM) {
              mapNotifier.setFloorPlanVisibility(true);
              _setStyle(_mapController);
            } else {
              mapNotifier.setFloorPlanVisibility(false);
              _resetStyle(_mapController);
            }
            if (MapHelper.isWithinHall(cameraPosition.target) &&
                mapNotifier.showFloorPlan == false) {
              mapNotifier.setEnterBuildingVisibility(true);
              setMarkers(eightFloorMarker);
            } else {
              mapNotifier.setEnterBuildingVisibility(false);
              eightFloorMarker = {};
            }
            mapNotifier.setCampusLatLng(cameraPosition.target);
          },
        )),
        Positioned(
          bottom: MediaQuery.of(context).padding.bottom + 16,
          right: MediaQuery.of(context).padding.right + 16,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'location',
                  onPressed: () {
                    goToCurrent();
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: constants.COLOR_CONCORDIA,
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
                          coordinates: (List<Coordinate> rooms) => {
                            drawShortestPath(
                                rooms[0], rooms[1], globals.disabilityMode)
                          },
                        ),
                      ),
                    );
                  },
                  backgroundColor: constants.COLOR_CONCORDIA,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.directions),
                ),
              ]),
        ),
        SearchBar(
            coordinate: (Coordinate coordinate) => {
                  Provider.of<MapNotifier>(context, listen: false)
                      .goToSpecifiedLatLng(coordinate)
                }),
        FloorSelectorEnterBuilding(
          selectedFloor: (int floor) => {
            updateFloor(floor),
            mapNotifier.setSelectedFloor(floor)
          },
          enterBuildingPressed: () => mapNotifier.goToHallSVG(),
        ),
      ],
    );
  }

  void updateFloor(int floor) {
    setState(() {
      if(shortestPath != null) {
        Path path = shortestPath['$floor'];
        if (path != null) {
          direction = {path.toPolyline()};
        }
        else {
          direction = {};
        }
      }
      if(floor == 9) {
        buildingHighlights.removeAll(eightFloorPolygon);
        buildingHighlights.addAll(ninthFloorPolygon);
      }
      else {
        buildingHighlights.removeAll(ninthFloorPolygon);
        buildingHighlights.addAll(eightFloorPolygon);
      }
    });
  }
  void _setStyle(GoogleMapController controller) async {
    print("Setting map style");
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  void _resetStyle(GoogleMapController controller) async {
    print("Reseting");
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style_reset.json');
    controller.setMapStyle(value);
  }

  void goToCurrent() async {
    final GoogleMapController controller = await _completer.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: constants.CAMERA_DEFAULT_ZOOM);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void drawShortestPath(
      Coordinate start, Coordinate end, bool isDisabilityEnabled) {
    BuildingSingleton buildingSingleton = new BuildingSingleton();
    Building hall;
    for (var building in buildingSingleton.buildings) {
      if (building.building.contains("Hall")) {
        hall = building;
      }
    }
    shortestPath = hall.shortestPath(start, end,
        isDisabilityFriendly: isDisabilityEnabled);
    Path path = shortestPath['9'];
    setState(() {
      direction = {path.toPolyline()};
    });
  }

  void setMarkers(Set<Marker> markers) {
    floorMarkers['8'].forEach((f) => eightFloorMarker.add(
        Marker(
            markerId: MarkerId(f.roomId),
            infoWindow: InfoWindow(title: f.roomId),
            position: f.toLatLng()

        )));
  }
}