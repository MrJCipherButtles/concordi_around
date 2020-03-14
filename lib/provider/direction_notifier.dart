import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionNotifier extends ChangeNotifier{
  DrivingMode mode = DrivingMode.CAR;
  LatLng startPoint;
  LatLng endPoint;

  void setTransportMode(DrivingMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  void setDirections(LatLng startPoint, LatLng endPoint) {
    this.startPoint = startPoint;
    this.endPoint = endPoint;
    notifyListeners();
  }
}