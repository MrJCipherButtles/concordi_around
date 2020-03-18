import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_direction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';

import '../service/map_constant.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;
  DrivingMode mode = DrivingMode.walking;
  Direction direction;
  List<String> directionSteps = List();
  Set<Polyline> polylines = {};

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
    setStepDirections();
    setPolylines();
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

  String getDuration() {
    String duration = "0 min";
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          duration = leg.duration.text;
        }
      }
    }
    return duration;
  }

  String getDistance() {
    String distance = "0 km";
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          distance = leg.distance.text;
        }
      }
    }
    return distance;
  }

  void setStepDirections() {
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          for (Steps step in leg.steps) {
            var document = parse(step.htmlInstructions);
            String parsedString = parse(document.body.text).documentElement.text;
            directionSteps.add(parsedString);
          }
        }
      }
    }
  }

  List<String> getStepDirections() {
    return directionSteps;
  }

  void clearStepDirections() { // Clear after polyline is drawn
  directionSteps.clear();
  }

  void setPolylines() {
    if(direction != null) {
      PolylinePoints polylinePoints = PolylinePoints();
      List<Routes> routes = direction.routes;
      List<PointLatLng> points = List();
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          for (Steps step in leg.steps) {
            points.addAll(polylinePoints.decodePolyline(step.polyline.points));
          }
        }
      }

      List<LatLng> latlngPoints = new List();
      for (PointLatLng latlng in points) {
        latlngPoints.add(LatLng(latlng.latitude, latlng.longitude));
      }

      polylines.add(Polyline(
        polylineId: PolylineId("direction"),
        points: latlngPoints,
        color: COLOR_CONCORDIA,
        width: 5,
      ));
    }
  }

  Set<Polyline> getPolylines() {
    return polylines;
  }

  void clearPolylines() {
    polylines.clear();
  }
}
