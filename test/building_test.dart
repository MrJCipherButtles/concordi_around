import 'package:concordi_around/models/building.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  test('Building instantiate with the right value', () {
    final building = Building("Henry F. Hall", "Hall", "SGW", LatLng(45.49726, -73.57893));

    final String t = building.toString();

    expect(t, "H : Henry");
  });
}