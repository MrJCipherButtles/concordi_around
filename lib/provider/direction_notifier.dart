import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:concordi_around/service/map_direction.dart';
import 'package:concordi_around/service/map_helper.dart';
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
  String duration = "0 min";
  int totalDuration = 0; // Only used for shuttle
  double totalDistance = 0; // Only used for shuttle
  int apiCallCounter = 0;

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
    apiCallCounter++;
    MapDirection _mapDirection = MapDirection();
    if (mode == DrivingMode.shuttle) {
      direction = await _mapDirection.getDirection(origin, destination,
          DrivingMode.transit.toString().replaceAll("DrivingMode.", ""));
    } else {
      direction = await _mapDirection.getDirection(
          origin, destination, mode.toString().replaceAll("DrivingMode.", ""));
    }
    setStepDirections();
    setDuration();
    setDistance();
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

  void setDuration() {
    if (direction != null) {
      List<Routes> routes = direction.routes;

      if (mode == DrivingMode.shuttle && MapHelper.isShuttleTaken) {
        for (Routes route in routes) {
          for (Legs leg in route.legs) {
            for (Steps step in leg.steps) {
              totalDuration += int.parse(step.duration.text
                  .replaceAll("mins", "")
                  .replaceAll("min", "")
                  .replaceAll(" ", ""));
            }
          }
        }
      } else {
        for (Routes route in routes) {
          for (Legs leg in route.legs) {
            duration = leg.duration.text;
          }
        }
      }
    }
  }

  void setDistance() {
    if (direction != null) {
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          if(leg.distance.text.toLowerCase().contains("km")) {
            totalDistance += double.parse(
              leg.distance.text.replaceAll("km", "").replaceAll(" ", ""));
          }
          else if (leg.distance.text.toLowerCase().contains("m")) {
            totalDistance += (double.parse(
              leg.distance.text.replaceAll("m", "").replaceAll(" ", "")))/1000;
          }
        }
      }
    }
  }

  void setStepDirections() {
    if (direction != null) {
      if (apiCallCounter == 2 && mode == DrivingMode.shuttle && MapHelper.isShuttleTaken) {
        // If statement is true, this is the 2nd api call for a shuttle direction
        directionSteps
            .add("Shuttle towards ${MapHelper.furthestShuttleCampus}");
      }
      List<Routes> routes = direction.routes;
      for (Routes route in routes) {
        for (Legs leg in route.legs) {
          for (Steps step in leg.steps) {
            var document = parse(step.htmlInstructions);
            String parsedString =
                parse(document.body.text).documentElement.text;
            directionSteps.add(parsedString);
          }
        }
      }
    }
  }

  void setPolylines() {
    if (direction != null) {
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
        polylineId: PolylineId("outdoor $apiCallCounter"),
        points: latlngPoints,
        color: COLOR_CONCORDIA,
        width: 5,
      ));
    }
  }

  List<String> getStepDirections() {
    return directionSteps;
  }

  String getDuration() {
    if (mode == DrivingMode.shuttle && MapHelper.isShuttleTaken) {
      return "${totalDuration + 30} mins"; // Add 30 minutes for shuttle travel time
    }
    return duration;
  }

  String getDistance() {
    if (mode == DrivingMode.shuttle && MapHelper.isShuttleTaken) {
      return "${(totalDistance + 6.9).toStringAsFixed(1)} km"; // Add 7 km  for shuttle travel distance time
    }
    return "${totalDistance.toStringAsFixed(1)} km";
  }

  Set<Polyline> getPolylines() {
    return polylines;
  }

  void clearAll() {
    polylines.clear();
    directionSteps.clear();
    apiCallCounter = 0;
    totalDuration = 0;
    totalDistance = 0;
  }
}
