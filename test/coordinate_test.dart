import 'package:concordi_around/models/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adding b to a.adjCoordinates should add a to b.adjCoordinates', () {
    final Coordinate a = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW');
    final Coordinate b = Coordinate(45.49734, -73.57918, '8', 'Hall', 'SGW');
    a.addAdjCoordinate(b);
    expect(a.adjCoordinates, {b});
    expect(b.adjCoordinates, {a});
  });
  group('adjacency', () {
    final Coordinate start = Coordinate(45.49713, -73.57919, '8', 'Hall', 'SGW');
    final Coordinate a = Coordinate(45.49719, -73.57933, '8', 'Hall', 'SGW', adjCoordinates: {start});
    final Coordinate b = Coordinate(45.49734, -73.57918, '8', 'Hall', 'SGW', adjCoordinates: {a});
    final Coordinate end = Coordinate(45.49749, -73.57905, '8', 'Hall', 'SGW', adjCoordinates: {start,b});
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
}