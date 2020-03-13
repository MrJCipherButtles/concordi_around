import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adding b to a.adjCoordinates should add a to b.adjCoordinates', () {
    var a = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    var b = Coordinate(45.49734, -73.57918, '8', 'Hall', 'SGW');
    a.addAdjCoordinate(b);
    expect(a.adjCoordinates, {b});
    expect(b.adjCoordinates, {a});
  });
  test('convert a to latlng', () {
    var a = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    var latlng = a.toLatLng();
    expect(latlng.latitude, a.lat);
    expect(latlng.longitude, a.lng);
  });
  group('adjacency', () {
    var start = Coordinate(45.49713, -73.57919, '8', 'Hall', 'SGW');
    var a = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', adjCoordinates: {start});
    var b = Coordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a});
    var end = Coordinate(45.49749, -73.57905, '8', 'Hall', 'SGW', adjCoordinates: {start,b});
    test('coordinate a and b should be adjacent to eachother', () {
      expect(a.isAdjacent(b), true);
    });
    test('coordinate start and b should not be adjacent to eachother', () {
      expect(start.isAdjacent(b), false);
    });
    test('coordinate start and end should be adjacent to eachother', () {
      expect(start.isAdjacent(end), true);
    });
  });
  group('equality', (){
    var a1 = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    var a2 = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    var b = Coordinate(45.49734, -73.57918, '8', 'Hall', 'SGW');
    test('a1 == a2 should be return true', (){
      expect(a1 == a2, true);
    });
    test('a1 != a2 should return false', (){
      expect(a1 != a2, false);
    });
    test('a1 == b should return false', (){
      expect(a1 == b, false);
    });
    test('a1 != b should return false', (){
      expect(a1 != b, true);
    });
  });
}