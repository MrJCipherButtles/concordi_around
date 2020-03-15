import 'dart:async';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/global.dart';
import 'package:concordi_around/model/building.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/model/path.dart';
import 'package:concordi_around/provider/direction_notifier.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_helper.dart';
import 'package:concordi_around/service/marker_helper.dart';
import 'package:concordi_around/service/polygon_helper.dart';
import 'package:concordi_around/view/goto_page_new.dart';
import 'package:concordi_around/widget/direction_panel.dart';
import 'package:concordi_around/widget/search/main_search_bar.dart';
import 'package:concordi_around/widget/svg_floor_plan/floor_selector_enter_building_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
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
  Set<Marker> marker = Set();

  var shortestPath;

  @override
  void initState() {
    super.initState();
    buildingHighlights = BuildingSingleton().getOutdoorBuildingHighlights();
    polygonHelper = PolygonHelper();
    markerHelper = MarkerHelper();
    buildingHighlights.addAll(polygonHelper.getFloorPolygon(9));
    _geolocator = Geolocator()..forceAndroidLocationManager;
    LocationOptions locationOptions = LocationOptions(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
    _positionStream =
        _geolocator.getPositionStream(locationOptions).listen((Position pos) {
      setState(() {
        _position = pos;
        _cameraPosition = CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: CAMERA_DEFAULT_ZOOM);
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
          markers: marker,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          onCameraMove: (CameraPosition cameraPosition) async {
            marker = SearchBar.searchResultMarker;
            GoogleMapController _mapController = await _completer.future;
            if (MapHelper.isWithinHall(cameraPosition.target) &&
                cameraPosition.zoom >= 18.5) {
              mapNotifier.setFloorPlanVisibility(true);
              _setStyle(_mapController);
              marker.addAll(
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
                  foregroundColor: COLOR_CONCORDIA,
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
                          drivingMode: (DrivingMode mode) =>
                              {directionNotifier.setDrivingMode(mode)},
                          startPointAndDestinationCoordinates: (List<Coordinate>
                                  startPointAndDestinationCoordinates) =>
                              {
                            directionNotifier.setShowDirectionPanel(true),
                            (startPointAndDestinationCoordinates[0]
                                        is RoomCoordinate &&
                                    startPointAndDestinationCoordinates[1]
                                        is RoomCoordinate)
                                ? drawShortestPath(
                                    startPointAndDestinationCoordinates[0],
                                    startPointAndDestinationCoordinates[1],
                                    disabilityMode)
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
                  backgroundColor: COLOR_CONCORDIA,
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
          enterBuildingPressed: () => mapNotifier.goToHallSVG(),
        ),
        DirectionPanel(),
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
        marker.removeAll(markerHelper.getFloorMarkers(8));
      } else if (floor == 8) {
        buildingHighlights.removeAll(polygonHelper.getFloorPolygon(9));
        marker.removeAll(markerHelper.getFloorMarkers(9));
      }
      marker.addAll(markerHelper.getFloorMarkers(floor));
      buildingHighlights.addAll(polygonHelper.getFloorPolygon(floor));
    });
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  void _resetStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style_reset.json');
    controller.setMapStyle(value);
    marker.removeAll(markerHelper.getFloorMarkers(8));
    marker.removeAll(markerHelper.getFloorMarkers(9));
  }

  void goToCurrent() async {
    final GoogleMapController controller = await _completer.future;
    _cameraPosition = CameraPosition(
        target: LatLng(_position.latitude, _position.longitude),
        zoom: CAMERA_DEFAULT_ZOOM);
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }

  void drawShortestPath(
      Coordinate start, Coordinate end, bool isDisabilityEnabled) {
    BuildingSingleton buildingSingleton = new BuildingSingleton();
    Building hall = buildingSingleton.buildings['H'];

    shortestPath = hall.shortestPath(start, end,
        isDisabilityFriendly: isDisabilityEnabled);
    // TODO: setState of direction should be set by listening to selectedFloor MapNotifier instead of hardcoded '9'
    setState(() {
      direction = {shortestPath['9'].toPolyline()};
    });
  }

  Future<void> drawDirectionPath(DirectionNotifier directionNotifier,
      Coordinate startPoint, Coordinate endPoint) async {
    await directionNotifier.navigateByCoordinates(
        startPoint, endPoint); // Important api call

    PolylinePoints polylinePoints = PolylinePoints();
    List<Routes> routes = directionNotifier.direction.routes;
    List<PointLatLng> points = List();
    for (Routes route in routes) {
      for (Legs leg in route.legs) {
        for (Steps step in leg.steps) {
          points.addAll(polylinePoints.decodePolyline(step.polyline.points));
        }
      }
    }
    _updatePolylines(points);
  }

  void _updatePolylines(List<PointLatLng> polyList) {
    Set<Polyline> _lines = {};

    List<LatLng> points = new List();
    for (PointLatLng latlng in polyList) {
      points.add(LatLng(latlng.latitude, latlng.longitude));
    }

    _lines.add(Polyline(
      polylineId: PolylineId("direction"),
      points: points,
      color: COLOR_CONCORDIA,
      width: 5,
    ));

    setState(() {
      direction = _lines;
    });
  }
}
