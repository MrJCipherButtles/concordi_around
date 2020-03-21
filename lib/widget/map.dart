import 'dart:async';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/global.dart';
import 'package:concordi_around/model/building.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/path.dart';
import 'package:concordi_around/provider/direction_notifier.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:concordi_around/service/map_helper.dart';
import 'package:concordi_around/service/marker_helper.dart';
import 'package:concordi_around/service/polygon_helper.dart';
import 'package:concordi_around/view/goto_page.dart';
import 'package:concordi_around/widget/direction_panel.dart';
import 'package:concordi_around/widget/search/main_search_bar.dart';
import 'package:concordi_around/widget/svg_floor_plan/floor_selector_enter_building_column.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
  MarkerHelper markerHelper;
  PolygonHelper polygonHelper;
  Set<Polyline> direction;
  Set<Polygon> buildingHighlights;
  Set<Marker> mapMarkers = {};

  var shortestPath;

  @override
  void initState() {
    super.initState();
    buildingHighlights = BuildingSingleton().getOutdoorBuildingHighlights();
    polygonHelper = PolygonHelper();
    markerHelper = MarkerHelper();
    _geolocator = Geolocator()..forceAndroidLocationManager;
    LocationOptions locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
    _positionStream =
        _geolocator.getPositionStream(locationOptions).listen((Position pos) {
      setState(() {
        _position = pos;
        _cameraPosition = CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: constant.CAMERA_DEFAULT_ZOOM);
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

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);
    DirectionNotifier directionNotifier =
        Provider.of<DirectionNotifier>(context);
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
          markers: mapMarkers,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          onCameraMove: (CameraPosition cameraPosition) async {
            GoogleMapController _mapController = await _completer.future;
            if (MapHelper.isWithinHall(cameraPosition.target) &&
                cameraPosition.zoom >= constant.CAMERA_INDOOR_ZOOM) {
              mapNotifier.setFloorPlanVisibility(true);
              _setStyle(_mapController, mapNotifier);
              mapMarkers.addAll(
                  markerHelper.getFloorMarkers(mapNotifier.selectedFloorPlan));
            } else {
              mapNotifier.setFloorPlanVisibility(false);
              _resetStyle(_mapController);
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
                  foregroundColor: constant.COLOR_CONCORDIA,
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
                        builder: (context) => GotoPage(
                          _position,
                          drivingMode: (constant.DrivingMode mode) =>
                              {directionNotifier.setDrivingMode(mode)},
                          startPointAndDestinationCoordinates: (List<Coordinate>
                                  startPointAndDestinationCoordinates) =>
                              {
                            (startPointAndDestinationCoordinates[0]
                                        is RoomCoordinate &&
                                    startPointAndDestinationCoordinates[1]
                                        is RoomCoordinate)
                                ? drawShortestPath(
                                    startPointAndDestinationCoordinates[0],
                                    startPointAndDestinationCoordinates[1],
                                    disabilityMode,
                                    mapNotifier,
                                    directionNotifier)
                                : drawDirectionPath(
                                    directionNotifier,
                                    startPointAndDestinationCoordinates[0],
                                    startPointAndDestinationCoordinates[1]),
                            //Moves camera to the starting point
                            mapNotifier.goToSpecifiedLatLng(
                                coordinate:
                                    startPointAndDestinationCoordinates[0]),
                          },
                        ),
                      ),
                    );
                  },
                  backgroundColor: constant.COLOR_CONCORDIA,
                  foregroundColor: Colors.white,
                  child: Icon(Icons.directions),
                ),
              ]),
        ),
        SearchBar(
            coordinate: (Future<Coordinate> coordinate) => {
                  Provider.of<MapNotifier>(context, listen: false)
                      .goToSpecifiedLatLng(futureCoordinate: coordinate)
                }),
        FloorSelectorEnterBuilding(
          selectedFloor: (int floor) =>
              {updateFloor(floor), mapNotifier.setSelectedFloor(floor)},
        ),
        DirectionPanel(
            removeDirectionPolyline: (bool removePolyline) => {
              direction = {},
              shortestPath = {},
              markerHelper.removeStartEndMarker(),
              mapMarkers.removeWhere((marker) =>
              marker.markerId.value == 'start' ||
                  marker.markerId.value == 'end'),
            }),
      ],
    );
  }

  void updateFloor(int floor) {
    setState(() {
      if (shortestPath != null) {
        Path path = shortestPath['$floor'];
        if (path != null) {
          direction = {path.toPolyline()};
        } else {
          direction = {};
        }
      }
      if (floor == 9) {
        buildingHighlights.removeAll(polygonHelper.getFloorPolygon(8));
        mapMarkers.removeAll(markerHelper.getFloorMarkers(8));
      } else if (floor == 8) {
        buildingHighlights.removeAll(polygonHelper.getFloorPolygon(9));
        mapMarkers.removeAll(markerHelper.getFloorMarkers(9));
      }
      mapMarkers.addAll(markerHelper.getFloorMarkers(floor));
      buildingHighlights.addAll(polygonHelper.getFloorPolygon(floor));
    });
  }

  void _setStyle(GoogleMapController controller, MapNotifier mapNotifier) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
    buildingHighlights.removeWhere((polygon) => polygon.polygonId.value == 'Henry F. Hall');
    buildingHighlights.addAll(polygonHelper.getFloorPolygon(mapNotifier.selectedFloorPlan));
  }

  void _resetStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style_reset.json');
    controller.setMapStyle(value);

    mapMarkers.removeAll(markerHelper.getFloorMarkers(8));
    mapMarkers.removeAll(markerHelper.getFloorMarkers(9));
    mapMarkers.removeWhere((marker) =>
    marker.markerId.value == 'start' || marker.markerId.value == 'end');
    buildingHighlights = {};
    buildingHighlights = BuildingSingleton().getOutdoorBuildingHighlights();
  }

  void goToCurrent() async {
    final GoogleMapController controller = await _completer.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: constant.CAMERA_DEFAULT_ZOOM);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void drawShortestPath(
      Coordinate start,
      Coordinate end,
      bool isDisabilityEnabled,
      MapNotifier mapNotifier,
      DirectionNotifier directionNotifier) {
    directionNotifier.setShowDirectionPanel(true);
    BuildingSingleton buildingSingleton = new BuildingSingleton();
    Building hall = buildingSingleton.buildings['H'];
    mapNotifier.setSelectedFloor(int.parse(start.floor));
    updateFloor(mapNotifier.selectedFloorPlan);
    shortestPath = hall.shortestPath(start, end,
        isDisabilityFriendly: isDisabilityEnabled);
    setState(() {
      direction = {
        shortestPath[mapNotifier.selectedFloorPlan.toString()].toPolyline()
      };
      markerHelper.setStartEndMarker(start, end);
    });
  }

  Future<void> drawDirectionPath(DirectionNotifier directionNotifier,
      Coordinate startPoint, Coordinate endPoint) async {
    MapHelper.setShuttleStops(startPoint);
    if (directionNotifier.mode == constant.DrivingMode.shuttle &&
        MapHelper.isShuttleRequired(endPoint)) {
      // await keyword is very important for synchronizing the calls!!!!!!
      await directionNotifier.navigateByCoordinates(
          startPoint,
          MapHelper
              .nearestShuttleStop); // Current position to closest shuttle stop
      await directionNotifier.navigateByCoordinates(
          MapHelper.furthestShuttleStop,
          endPoint); // Furthest shuttle stop to end point
    } else {
      await directionNotifier.navigateByCoordinates(startPoint, endPoint);
    }
    directionNotifier.setShowDirectionPanel(true);
    setState(() {
      direction = directionNotifier.getPolylines();
    });
  }
}
