import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter/cupertino.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;
  DrivingMode mode = DrivingMode.Car;
  Direction direction;
  String duration;
  List<String> directions;

  void setShowDirectionPanel(bool visiblity) {
    showDirectionPanel = visiblity;
    notifyListeners();
  }

  void setDrivingMode(DrivingMode mode) {
    this.mode = mode;
    notifyListeners();
  }

  int setTotalDuration(Direction direction) {
    int duration = 0;
    for(Routes route in direction.routes) {
      duration += route.duration.value;
    }
    return duration;
  }

  List<String> setDirections(Direction direction) {
    for(Routes route in direction.routes) {
      for(Legs leg in route.legs) {
        for(Steps step in leg.steps) {
          directions.add(step.toString());
        }
      }
    }
    return directions;
  }
}
