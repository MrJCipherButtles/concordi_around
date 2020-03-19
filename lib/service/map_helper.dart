import 'dart:math';

import 'package:concordi_around/data/data_points.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static String furthestShuttleCampus = "SGW";
  static String nearestShuttleCampus = "LOY";
  static bool _isShuttleTaken = false;
  static Coordinate _nearestShuttleStop;
  static Coordinate _furthestShuttleStop;

  static bool get isShuttleTaken => _isShuttleTaken;
  static Coordinate get nearestShuttleStop => _nearestShuttleStop;
  static Coordinate get furthestShuttleStop => _furthestShuttleStop;

  static bool isWithinHallStrictBound(LatLng latLng) {
    List<LatLng> coordsList = [LatLng(45.49726709926478, -73.57894677668811)];

    return (latLng == null
        ? false
        : boundsFromLatLngList(coordsList).contains(latLng));
  }

  static bool isWithinHall(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.49718, -73.57968),
      LatLng(45.49675, -73.57878),
      LatLng(45.49741, -73.57819),
      LatLng(45.49781, -73.57906)
    ];
    return (latLng == null
        ? false
        : boundsFromLatLngList(coordsList).contains(latLng));
  }

  static bool isWithinLoyola(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.458355, -73.633476),
      LatLng(45.459243, -73.640739),
      LatLng(45.457324, -73.642574),
      LatLng(45.455706, -73.638207)
    ];
    return (latLng == null
        ? false
        : boundsFromLatLngList(coordsList).contains(latLng));
  }

  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  static void setShuttleStops(Coordinate startPoint) {
    double distanceToSGW = calculateDistance(
        startPoint.toLatLng(), shuttleStops['SGW'].toLatLng());
    double distanceToLOY = calculateDistance(
        startPoint.toLatLng(), shuttleStops['LOY'].toLatLng());
    if (distanceToLOY > distanceToSGW) {
      nearestShuttleCampus = "SGW";
      furthestShuttleCampus = "Loyola";
      _nearestShuttleStop = shuttleStops['SGW'];
      _furthestShuttleStop = shuttleStops['LOY'];
    } else {
      nearestShuttleCampus = "Loyola";
      furthestShuttleCampus = "SGW";
      _nearestShuttleStop = shuttleStops['LOY'];
      _furthestShuttleStop = shuttleStops['SGW'];
    }
  }

  static bool isShuttleRequired(Coordinate endPoint) {
    double distanceToClosestStop = calculateDistance(
        endPoint.toLatLng(),_nearestShuttleStop.toLatLng());
    double distanceToFurthestStop = calculateDistance(
        endPoint.toLatLng(), _furthestShuttleStop.toLatLng());
    _isShuttleTaken = distanceToFurthestStop < distanceToClosestStop;
    return _isShuttleTaken;
  }

  static double calculateDistance(LatLng first, LatLng second) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((second.latitude - first.latitude) * p) / 2 +
        c(first.latitude * p) *
            c(second.latitude * p) *
            (1 - c((second.longitude - first.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
