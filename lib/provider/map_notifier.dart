import 'dart:async';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/services/map_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/services/constants.dart' as constants;

class MapNotifier with ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  bool showFloorPlan = false;
  bool showEnterBuilding = false;
  int selectedFloorPlan = 9;
  String currentCampus = 'SGW';

  void setFloorPlanVisibility(bool visibility) {
    showFloorPlan = visibility;
    notifyListeners();
  }

  void setSelectedFloor(int selectedFloor) {
    selectedFloorPlan = selectedFloor;
    notifyListeners();
  }

  void setEnterBuildingVisibility(bool visibility) {
    showEnterBuilding = visibility;
    notifyListeners();
  }

  void setCampusLatLng(LatLng latLng) {
    if (MapHelper.isWithinLoyola(latLng)) {
      currentCampus = 'LOY';
    } else {
      currentCampus = 'SGW';
    }
    notifyListeners();
  }

  void setCampusString(String campus) {
    currentCampus = campus;
    notifyListeners();
  }

  Future<void> goToSpecifiedLatLng(Coordinate coordinate) async {
    final GoogleMapController controller = await _completer.future;
    if (coordinate != null) {
      CameraPosition _newPosition = CameraPosition(
          target: coordinate.toLatLng(), zoom: constants.CAMERA_DEFAULT_ZOOM);
      controller.animateCamera(CameraUpdate.newCameraPosition(_newPosition));
    }
  }

  Future<void> goToHallSVG() async {
    // May need return type of Future<void>, not sure yet
    CameraPosition _currentPos = CameraPosition(
        bearing: 123.31752014160156,
        target: LatLng(45.49726709926478, -73.57894677668811),
        tilt: 0.0,
        zoom: 19.03557586669922);

    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }

  Future<void> toggleCampus(LatLng latLng) async {
    final c = await _completer.future;
    final p = CameraPosition(
      target: latLng,
      zoom: constants.CAMERA_DEFAULT_ZOOM,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }
}