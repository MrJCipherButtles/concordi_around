import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHelper {
  static bool isWithinHallStrictBound(LatLng latLng) {
    List<LatLng> coordsList = [LatLng(45.49726709926478, -73.57894677668811)];

    return boundsFromLatLngList(coordsList).contains(latLng);
  }

  static bool isWithinHall(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.49718, -73.57968),
      LatLng(45.49675, -73.57878),
      LatLng(45.49741, -73.57819),
      LatLng(45.49781, -73.57906)
    ];
    return boundsFromLatLngList(coordsList).contains(latLng);
  }

  static bool isWithinSGW(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.492532, -73.576848),
      LatLng(45.496587, -73.581582),
      LatLng(45.498974, -73.579218),
      LatLng(45.496573, -73.572700),
    ];
    return boundsFromLatLngList(coordsList).contains(latLng);
  }

  static bool isWithinLoyola(LatLng latLng) {
    List<LatLng> coordsList = [
      LatLng(45.458355, -73.633476),
      LatLng(45.459243, -73.640739),
      LatLng(45.457324, -73.642574),
      LatLng(45.455706, -73.638207)
    ];
    return boundsFromLatLngList(coordsList).contains(latLng);
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
}