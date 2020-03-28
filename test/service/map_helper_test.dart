import 'package:concordi_around/service/map_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/data/data_points.dart';

void main() {
  group("Campus tests:", () {
    test('Should be in Hall Building', () {
      expect(MapHelper.isWithinHall(LatLng(45.497222, -73.578791)), true);
      expect(MapHelper.isWithinHall(LatLng(45.496865, -73.578056)), false);
      expect(MapHelper.isWithinHall(null), false);
    });

    test('Should be within the bounds of Hall Building on the map', () {
      expect(
          MapHelper.isWithinHallStrictBound(
              LatLng(45.49726709926478, -73.57894677668811)),
          true);
      expect(MapHelper.isWithinHallStrictBound(LatLng(45.494901, -73.579351)),
          false);
      expect(MapHelper.isWithinHallStrictBound(null), false);
    });

    test('Should be within Loyola campus', () {
      expect(MapHelper.isWithinLoyola(LatLng(45.458065, -73.640538)), true);
      expect(MapHelper.isWithinLoyola(LatLng(45.463359, -73.636186)), false);
      expect(MapHelper.isWithinLoyola(null), false);
    });

    test('Results should be according to Loyola live location', () {
      MapHelper.setShuttleStops(Coordinate(45.458306, -73.640352, "0", "CB",
          "LOY")); //Central (Loyola) Building Coordinates
      expect(MapHelper.nearestShuttleCampus, 'Loyola');
      expect(MapHelper.furthestShuttleCampus, 'SGW');
      expect(MapHelper.nearestShuttleStop, shuttleStops['LOY']);
      expect(MapHelper.furthestShuttleStop, shuttleStops['SGW']);
      expect(MapHelper.isShuttleTaken, false);
    });

    test('Results should be according to Hall live location', () {
      MapHelper.setShuttleStops(Coordinate(
          45.49726, -73.57893, "0", "H", "SGW")); //Hall Building Coordinates
      expect(MapHelper.nearestShuttleCampus, 'SGW');
      expect(MapHelper.furthestShuttleCampus, 'Loyola');
      expect(MapHelper.nearestShuttleStop, shuttleStops['SGW']);
      expect(MapHelper.furthestShuttleStop, shuttleStops['LOY']);
      expect(MapHelper.isShuttleTaken, false);
    });

    test('Shuttle should be required', () {
      //Going to Loyola from Hall (SGW)
      expect(
          MapHelper.isShuttleRequired(
              Coordinate(45.458306, -73.640352, "0", "CB", "LOY")),
          true);
    });

    test('Shuttle should not be required', () {
      //Going to JMSB (SGW) from Hall (SGW)
      expect(
          MapHelper.isShuttleRequired(
              Coordinate(45.4954, -73.57909, "0", "JMSB", "SGW")),
          false);
    });
  });
}
