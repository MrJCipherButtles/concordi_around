import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/path.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  test('distance for path p1', () {
    var a1 = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b1 = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a1});
    var a2 = PortalCoordinate(45.49719, -73.57933, '9', 'Hall', 'SGW', adjCoordinates: {a1}, isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49734, -73.57918, '9', 'Hall', 'SGW', adjCoordinates: {a2, b1});
    var p1 = Path([b1,a1,a2,b2]);
    expect(p1.length(), closeTo(40.74, 0.1));
  });
  group('disability-friendly', () {
    var a1 = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b1 = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a1});
    var a2 = PortalCoordinate(45.49719, -73.57933, '9', 'Hall', 'SGW', adjCoordinates: {a1}, isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49734, -73.57918, '9', 'Hall', 'SGW', adjCoordinates: {a2, b1});
    var p1 = Path([b1,a1,a2,b2]);
    var p2 = Path([a1,b1,b2,a2]);
    test('path p1 should be disability-friendly', () {
      expect(p1.isDisabilityFriendly(), true);
    });
    test('path p2 should not be disability-friendly', () {
      expect(p2.isDisabilityFriendly(), false);
    });
  });
  test('coordinates should be in order of path traversal', () {
    var a1 = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b1 = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a1});
    var a2 = PortalCoordinate(45.49719, -73.57933, '9', 'Hall', 'SGW', adjCoordinates: {a1}, isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49734, -73.57918, '9', 'Hall', 'SGW', adjCoordinates: {a2, b1});
    var p1 = Path([a1,b1,b2,a2]);
    expect(p1.coordinatesInOrder(), [a1,b1,b2,a2]);
  });
  test('polyline should match path', () {
    var a1 = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b1 = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a1});
    var a2 = PortalCoordinate(45.49719, -73.57933, '9', 'Hall', 'SGW', adjCoordinates: {a1}, isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49734, -73.57918, '9', 'Hall', 'SGW', adjCoordinates: {a2, b1});
    var p1 = Path([a1,b1,b2,a2]);

    var polyline = p1.toPolyline();

    var coordinates = p1.coordinatesInOrder();
    var points = <LatLng>[];
    coordinates.forEach((p) => points.add(p.toLatLng()));

    expect(points, polyline.points);
  });
}