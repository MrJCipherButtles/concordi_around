import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_direction.dart';
import 'package:flutter/cupertino.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;
  DrivingMode mode = DrivingMode.Car;

  void setShowDirectionPanel(bool visiblity) {
    showDirectionPanel = visiblity;
    notifyListeners();
  }

  void setDrivingMode(DrivingMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  void navigateByName(String origin, String destination) {
    String _transportationMode;
    switch(this.mode) {
      case DrivingMode.Car: {
        _transportationMode = "driving";
      }
      break;

      case DrivingMode.Bike: {
        _transportationMode = "bicycling";
      }
      break;

      case DrivingMode.Walk: {
        _transportationMode = "walking";
      }
      break;

      case DrivingMode.Bus: {
        _transportationMode = "transit";
      }
      break;
    }

    MapDirection _mapDirection = MapDirection();

    // Direction direction = _mapDirection.getDirection(origin, destination, _transportationMode);
  }

  void navigateByCoordinates(Coordinate originCoordinates, Coordinate destinationCoordinates) {
    String originLatitude = originCoordinates.lat.toString();
    String originLongitude = originCoordinates.lng.toString();
    String destinationLatitude = destinationCoordinates.lat.toString();
    String destinationLongitude = destinationCoordinates.lng.toString();
    String origin = "$originLatitude,$originLongitude";
    String destination = "$destinationLatitude,$destinationLongitude";

    navigateByName(origin, destination);
  }
}
