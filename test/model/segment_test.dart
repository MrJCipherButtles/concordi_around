import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/segment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('distance between a and b', () {
    var a = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    var b = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a});
    var ab = Segment(a,b);
    expect(ab.length(), closeTo(20.37, 0.1));
  });
  group('disability-friendly', () {
    var a1 = PortalCoordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b1 = PortalCoordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a1});
    var a2 = PortalCoordinate(45.49719, -73.57933, '9', 'Hall', 'SGW', adjCoordinates: {a1}, isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49734, -73.57918, '9', 'Hall', 'SGW', adjCoordinates: {a2, b1});
    var a1a2 = Segment(a1,a2);
    var b1b2 = Segment(b1,b2);
    var a1b1 = Segment(a1,b1);
    test('segment a1a2 should be disability-friendly', () {
      expect(a1a2.isDisabilityFriendly(), true);
    });
    test('segment b1b2 should not be disability-friendly', () {
      expect(b1b2.isDisabilityFriendly(), false);
    });
    test('segment a1b1 should be disability-friendly', () {
      expect(a1b1.isDisabilityFriendly(), true);
    });
  });
}