import 'package:concordi_around/models/building.dart';
import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/models/floor.dart';
import 'package:concordi_around/models/path.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('floor count should be incremented', () {
    var floor = Floor('8');
    var building = Building('Hall');
    building.addFloor(floor);
    expect(building.floors.length, 1);
  });
  group('shortest path', ()
  {
    var a = Coordinate(45.49719, -73.57933, '1', 'Hall', 'SGW');
    var b = Coordinate(45.49735, -73.57918, '1', 'Hall', 'SGW');
    var c = PortalCoordinate(45.49755, -73.57899, '1', 'Hall', 'SGW');
    var d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW');
    var e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW');
    var f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW');
    var x = PortalCoordinate(45.49720, -73.57887, '1', 'Hall', 'SGW', isDisabilityFriendly: true);
    var y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW');

    var a2 = Coordinate(45.49719, -73.57933, '2', 'Hall', 'SGW');
    var b2 = Coordinate(45.49735, -73.57918, '2', 'Hall', 'SGW');
    var c2 = PortalCoordinate(45.49755, -73.57899, '2', 'Hall', 'SGW');
    var d2 = Coordinate(45.49734, -73.57855, '2', 'Hall', 'SGW');
    var e2 = Coordinate(45.49714, -73.57875, '2', 'Hall', 'SGW');
    var f2 = Coordinate(45.49698, -73.57888, '2', 'Hall', 'SGW');
    var x2 = PortalCoordinate(45.49720, -73.57887, '2', 'Hall', 'SGW', isDisabilityFriendly: true);
    var y2 = Coordinate(45.49741, -73.57868, '2', 'Hall', 'SGW');

    a.adjCoordinates = {f, b};
    b.adjCoordinates = {a, x, c};
    c.adjCoordinates = {b, y, c2};
    d.adjCoordinates = {y, e};
    e.adjCoordinates = {d};
    f.adjCoordinates = {a};
    x.adjCoordinates = {b, y, x2};
    y.adjCoordinates = {c, x, d};

    a2.adjCoordinates = {f2, b2};
    b2.adjCoordinates = {a2, x2, c2};
    c2.adjCoordinates = {b2, y2, c};
    d2.adjCoordinates = {y2, e2};
    e2.adjCoordinates = {d2};
    f2.adjCoordinates = {a2};
    x2.adjCoordinates = {b2, y2, x};
    y2.adjCoordinates = {c2, x2, d2};

    var floor1 = Floor('1');
    var floor2 = Floor('2');
    floor1.coordinates = {a, b, c, d, e, f, x, y};
    floor2.coordinates = {a2, b2, c2, d2, e2, f2, x2, y2};

    var building = Building('Hall');
    building.addFloor(floor1);
    building.addFloor(floor2);

    test('should get the shortest path, disability = false', () {
      expect(building.shortestPath(f, e2)['1'].toString(), Path([f,a,b,c]).toString());
      expect(building.shortestPath(f, e2)['2'].toString(), Path([c2,y2,d2,e2]).toString());
    });
    test('should get the shortest path, disability = true', () {
      expect(building.shortestPath(f, e2, isDisabilityFriendly: true)['1'].toString(), Path([f,a,b,x]).toString());
      expect(building.shortestPath(f, e2, isDisabilityFriendly: true)['2'].toString(), Path([x2,y2,d2,e2]).toString());
    });
  });
}