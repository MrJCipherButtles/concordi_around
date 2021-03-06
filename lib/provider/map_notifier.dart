import 'dart:async';
import '../model/coordinate.dart';
import '../service/map_constant.dart' as constant;
import '../service/map_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapNotifier with ChangeNotifier {
  Completer<GoogleMapController> _completer = Completer();
  Completer<GoogleMapController> get getCompleter {
    return _completer;
  }

  bool showFloorPlan = false;
  bool showEnterBuilding = false;
  bool showInfo = false;
  LatLng selectedLatlng = LatLng(0, 0);
  int selectedFloorPlan = 9;
  String currentCampus = 'SGW';
  Set<Color> campusSelected = {Colors.white, constant.COLOR_CONCORDIA};
  Set<Color> campusNotSelected = {constant.COLOR_CONCORDIA, Colors.white};

  Set<Color> sgwButtonColor = {constant.COLOR_CONCORDIA, Colors.white};
  Set<Color> loyButtonColor = {constant.COLOR_CONCORDIA, Colors.white};

  void setPopupInfoVisibility(bool visibility) {
    showInfo = visibility;
    notifyListeners();
  }

  void setPlaceLatLng(LatLng latLng) {
    selectedLatlng = latLng;
    notifyListeners();
  }

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
    if (campus == 'SGW') {
      sgwButtonColor = campusSelected;
      loyButtonColor = campusNotSelected;
    }
    if (campus == 'LOY') {
      sgwButtonColor = campusNotSelected;
      loyButtonColor = campusSelected;
    }
    notifyListeners();
  }

//Must include a named parameter for coordinate OR future coordinate, NOT BOTH
  Future<void> goToSpecifiedLatLng(
      {Future<Coordinate> futureCoordinate, Coordinate coordinate}) async {
    if ((futureCoordinate == null && coordinate == null) ||
        (futureCoordinate != null && coordinate != null)) {
      return;
    }
    final GoogleMapController controller = await _completer.future;
    Coordinate c;
    if (coordinate != null) {
      c = coordinate;
    } else {
      c = await futureCoordinate;
    }
    setPlaceLatLng(c.toLatLng());
    CameraPosition _newPosition =
        CameraPosition(target: c.toLatLng(), zoom: constant.CAMERA_INDOOR_ZOOM);
    controller.animateCamera(CameraUpdate.newCameraPosition(_newPosition));
  }

  Future<void> toggleCampus(LatLng latLng) async {
    final c = await _completer.future;
    final p = CameraPosition(
      target: latLng,
      zoom: constant.CAMERA_DEFAULT_ZOOM,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }
}
