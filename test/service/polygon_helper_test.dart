import 'package:concordi_around/service/polygon_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  test('Polygon Helper Unit Test', () {
    PolygonHelper polygonHelper = PolygonHelper();
    Set<Polygon> eightFloorPolygon = polygonHelper.eightFloorPolygon;
    Set<Polygon> ninthFloorPolygon = polygonHelper.ninthFloorPolygon;

    expect(polygonHelper.getFloorPolygon(8), eightFloorPolygon);
    expect(polygonHelper.getFloorPolygon(9), ninthFloorPolygon);
  });
}