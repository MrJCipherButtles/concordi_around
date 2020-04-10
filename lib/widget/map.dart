import 'dart:async';
import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/data/data_points.dart';
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
import 'package:concordi_around/widget/floor_selector/floor_selector_enter_building_column.dart';
import 'package:concordi_around/widget/building_popup.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:math';

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
  Set<Polyline> direction = {};
  Set<Polygon> buildingHighlights;
  Set<Marker> mapMarkers = {};
  bool _myLocationEnabled = false;
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
        if (!_myLocationEnabled) {
          goToCurrent();
          _myLocationEnabled = true;
        }
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

    return Stack(
      children: <Widget>[
        Container(
            child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: _myLocationEnabled,
          myLocationButtonEnabled: false,
          compassEnabled: false,
          indoorViewEnabled: false,
          mapToolbarEnabled: false,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          tiltGesturesEnabled: true,
          zoomGesturesEnabled: true,
          polygons: buildingHighlights,
          polylines: direction,
          markers: mapMarkers,
          onLongPress: (LatLng curr) {
            handleMapOnLongPress(curr, mapNotifier: mapNotifier);
            mapNotifier.selectedLatlng = curr;
          },
          initialCameraPosition: _cameraPosition ??
              CameraPosition(target: LatLng(45.4977298, -73.579034)),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
          onCameraMove: (CameraPosition cameraPosition) async {
            GoogleMapController _mapController = await _completer.future;
            if (cameraPosition.zoom >= 16.5) {
              mapMarkers.addAll(markerHelper.getBuildingMarkers());
            } else {
              mapMarkers.removeWhere((marker) =>
                  marker.markerId.value.startsWith('buildingMarker'));
            }
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
                  tooltip: "direction page button",
                  onPressed: () {
                    mapMarkers.removeWhere(
                        (marker) => marker.markerId.value == 'pop-up');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GotoPage(
                          _position,
                          drivingMode: (constant.DrivingMode mode) =>
                              {directionNotifier.setDrivingMode(mode)},
                          startPointAndDestinationCoordinates:
                              (List<Coordinate> directionCoordinates) => {
                            drawPath(
                                directionCoordinates[0],
                                directionCoordinates[1],
                                disabilityMode,
                                mapNotifier,
                                directionNotifier)
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
        SearchBar(coordinate: (Future<Coordinate> coordinate) async {
          setState(() {
            directionNotifier.setShowDirectionPanel(false);
            mapMarkers
                .removeWhere((marker) => marker.markerId.value == 'pop-up');
          });
          mapNotifier.goToSpecifiedLatLng(futureCoordinate: coordinate);
          var result = await coordinate;
          if (!(result is RoomCoordinate)) {
            mapNotifier.setPopupInfoVisibility(true);
          }
          mapMarkers.add(Marker(
              markerId: MarkerId("pop-up"),
              position: LatLng(result.lat, result.lng),
              infoWindow: InfoWindow(title: "${result.building}")));
        }),
        FloorSelectorEnterBuilding(
          selectedFloor: (int floor) =>
              {updateFloor(floor), mapNotifier.setSelectedFloor(floor)},
        ),
        BuildingPopup(
          onClosePanel: () => {
            mapMarkers
                .removeWhere((marker) => marker.markerId.value == 'pop-up')
          },
          onGetDirectionSelected: () => {
            mapMarkers
                .removeWhere((marker) => marker.markerId.value == 'pop-up'),
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GotoPage(
                  _position,
                  drivingMode: (constant.DrivingMode mode) =>
                      {directionNotifier.setDrivingMode(mode)},
                  destination: Coordinate(
                      SearchBar.searchResult.lat,
                      SearchBar.searchResult.lng,
                      "",
                      "${SearchBar.searchResult.building}",
                      ""),
                  startPointAndDestinationCoordinates:
                      (List<Coordinate> directionCoordinates) => {
                    drawPath(directionCoordinates[0], directionCoordinates[1],
                        disabilityMode, mapNotifier, directionNotifier)
                  },
                ),
              ),
            ),
            mapNotifier.setPopupInfoVisibility(false)
          },
        ),
        DirectionPanel(
            removeDirectionPolyline: (bool removePolyline) => {
                  direction.clear(),
                  shortestPath = {},
                  markerHelper.removeStartEndMarker(),
                  mapMarkers.removeWhere((marker) =>
                      marker.markerId.value == 'start' ||
                      marker.markerId.value == 'end' ||
                      marker.markerId.value == 'destination'),
                }),
      ],
    );
  }

  void updateFloor(int floor) {
    setState(() {
      if (shortestPath != null) {
        Path path = shortestPath['$floor'];
        direction.removeWhere((polyline) =>
            !(polyline.polylineId.toString().contains("outdoor")));
        if (path != null) {
          direction.addAll({path.toPolyline()});
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

  void _setStyle(
      GoogleMapController controller, MapNotifier mapNotifier) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
    buildingHighlights
        .removeWhere((polygon) => polygon.polygonId.value == 'Henry F. Hall');
    buildingHighlights
        .addAll(polygonHelper.getFloorPolygon(mapNotifier.selectedFloorPlan));
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

  void drawPath(
      Coordinate origin,
      Coordinate destination,
      bool isDisabilityEnabled,
      MapNotifier mapNotifier,
      DirectionNotifier directionNotifier) {
    if (origin is RoomCoordinate && destination is RoomCoordinate)
      drawIndoorPath(
          origin, destination, disabilityMode, mapNotifier, directionNotifier);
    else if (origin is RoomCoordinate || destination is RoomCoordinate)
      drawCombinedPath(
          origin, destination, disabilityMode, mapNotifier, directionNotifier);
    else
      drawOutdoorPath(origin, destination, directionNotifier);

    directionNotifier.setShowDirectionPanel(true);

    //Moves camera to the starting point
    mapNotifier.goToSpecifiedLatLng(coordinate: origin);
  }

  void drawIndoorPath(
      Coordinate origin,
      Coordinate destination,
      bool isDisabilityEnabled,
      MapNotifier mapNotifier,
      DirectionNotifier directionNotifier) {
    BuildingSingleton buildingSingleton = new BuildingSingleton();
    Building hall = buildingSingleton.buildings['H'];
    mapNotifier.setSelectedFloor(int.parse(origin.floor));
    updateFloor(mapNotifier.selectedFloorPlan);
    shortestPath = hall.shortestPath(origin, destination,
        isDisabilityFriendly: isDisabilityEnabled);
    setState(() {
      direction.addAll({
        shortestPath[mapNotifier.selectedFloorPlan.toString()].toPolyline()
      });
      markerHelper.setStartEndMarker(origin, destination);
    });
  }

  Future<void> drawOutdoorPath(Coordinate origin, Coordinate destination,
      DirectionNotifier directionNotifier) async {
    MapHelper.setShuttleStops(origin);
    if (directionNotifier.mode == constant.DrivingMode.shuttle &&
        MapHelper.isShuttleRequired(destination)) {
      // await keyword is very important for synchronizing the calls!!!!!!
      await directionNotifier.navigateByCoordinates(
          origin,
          MapHelper
              .nearestShuttleStop); // Current position to closest shuttle stop
      await directionNotifier.navigateByCoordinates(
          MapHelper.furthestShuttleStop,
          destination); // Furthest shuttle stop to end point
    } else {
      await directionNotifier.navigateByCoordinates(origin, destination);
    }
    setState(() {
      direction.addAll(directionNotifier.getPolylines());
    });

    mapMarkers.add(markerHelper.getDestinationMarker(destination.toLatLng()));
  }

  Future<void> drawCombinedPath(
      Coordinate origin,
      Coordinate destination,
      bool isDisabilityEnabled,
      MapNotifier mapNotifier,
      DirectionNotifier directionNotifier) async {
    if (origin is RoomCoordinate) {
      drawOutdoorPath(mainEntrance["Hall"], destination, directionNotifier);
      isDisabilityEnabled
          ? drawIndoorPath(origin, BuildingSingleton().h8F12,
              isDisabilityEnabled, mapNotifier, directionNotifier)
          : drawIndoorPath(origin, BuildingSingleton().h8F16,
              isDisabilityEnabled, mapNotifier, directionNotifier);
    } else {
      drawOutdoorPath(origin, mainEntrance["Hall"], directionNotifier);
      isDisabilityEnabled
          ? drawIndoorPath(BuildingSingleton().h8F12, destination,
              isDisabilityEnabled, mapNotifier, directionNotifier)
          : drawIndoorPath(BuildingSingleton().h8F16, destination,
              isDisabilityEnabled, mapNotifier, directionNotifier);
    }
  }

  // If user long presses on a buildings marker it will show the pop up
  Future<void> handleMapOnLongPress(LatLng point, {MapNotifier mapNotifier}) async {
    List<Building> buildingsList = BuildingSingleton().getBuildingList();
    for (Building building in buildingsList) {
      if (pow(
                  (pow(point.latitude - building.coordinate.lat, 2) +
                      pow(point.longitude - building.coordinate.lng, 2)),
                  0.5) *
              100000 <
          20) {
        await PositionedFloatingSearchBar().getPlaceDetails(building.placeId);
        mapNotifier.setPopupInfoVisibility(true);
      }
    }
  }
}
