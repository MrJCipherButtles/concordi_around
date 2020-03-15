import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_direction.dart';
import 'package:flutter/cupertino.dart';

import '../service/map_constant.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;
  DrivingMode mode = DrivingMode.walking;
  Direction direction;

  void setShowDirectionPanel(bool visiblity) {
    showDirectionPanel = visiblity;
    notifyListeners();
  }

  void setDrivingMode(DrivingMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  Direction getDirection() {
    return direction;
  }

  Future<Direction> navigateByName(String origin, String destination) async {
    MapDirection _mapDirection = MapDirection();
    direction = await _mapDirection.getDirection(
        origin, destination, mode.toString().replaceAll("DrivingMode.", ""));
    return direction;
  }

  Future<Direction> navigateByCoordinates(
      Coordinate originCoordinates, Coordinate destinationCoordinates) async {
    String originLatitude = originCoordinates.lat.toString();
    String originLongitude = originCoordinates.lng.toString();
    String destinationLatitude = destinationCoordinates.lat.toString();
    String destinationLongitude = destinationCoordinates.lng.toString();
    String origin = "$originLatitude,$originLongitude";
    String destination = "$destinationLatitude,$destinationLongitude";

    return navigateByName(origin, destination);
  }

  int getDuration() {
    int duration = 0;
    if(direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
      for (Legs leg in route.legs) {
        for (Steps step in leg.steps) {
          duration += int.parse(step.duration.text.split(" ")[0]);
        }
      }
    }
  }
  return duration;
  }
}
