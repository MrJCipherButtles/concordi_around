import 'package:concordi_around/models/coordinate.dart';
import 'package:concordi_around/models/floor.dart';
import 'package:concordi_around/models/path.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shortest path from f to e', () {
    final a = Coordinate(45.49719, -73.57933, '1', 'Hall', 'SGW');
    final b = Coordinate(45.49735, -73.57918, '1', 'Hall', 'SGW');
    final c = Coordinate(45.49755, -73.57899, '1', 'Hall', 'SGW');
    final d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW');
    final e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW');
    final f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW');
    final x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW');
    final y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW');

    a.adjCoordinates = {f,b,a};
    b.adjCoordinates = {a,x,c};
    c.adjCoordinates = {b,y};
    d.adjCoordinates = {y,e};
    e.adjCoordinates = {d};
    f.adjCoordinates = {a};
    x.adjCoordinates = {b,y};
    y.adjCoordinates = {c,x,d};

    var floor = Floor('1');
    floor.coordinates = {a,b,c,d,e,f,x,y};

    expect(floor.shortestPath(f, e).toString(), Path([f,a,b,c,y,d,e]).toString());
  });
  group('coordinate types', () {
    final a = Coordinate(45.49719, -73.57933, '1', 'Hall', 'SGW', type: 'A');
    final b = Coordinate(45.49735, -73.57918, '1', 'Hall', 'SGW', type: 'B');
    final c = Coordinate(45.49755, -73.57899, '1', 'Hall', 'SGW', type: 'C');
    final d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW', type: 'A');
    final e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW', type: 'B');
    final f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW', type: 'C');
    final x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW', type: 'A');
    final y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW', type: 'B');

    a.adjCoordinates = {f,b,a};
    b.adjCoordinates = {a,x,c};
    c.adjCoordinates = {b,y};
    d.adjCoordinates = {y,e};
    e.adjCoordinates = {d};
    f.adjCoordinates = {a};
    x.adjCoordinates = {b,y};
    y.adjCoordinates = {c,x,d};

    var floor = Floor('1');
    floor.coordinates = {a,b,c,d,e,f,x,y};

    test('should get all A type coordinates', () {
      expect(floor.coordinatesByGivenTypes(['A']), [a,d,x]);
    });
    test('should get all A and C type coordinates', () {
      expect(floor.coordinatesByGivenTypes(['A','C']), [a,c,d,f,x]);
    });
  });
  group('valid exit coordinates', ()
  {
    final a = PortalCoordinate(45.49719, -73.57933, '1', 'Hall', 'SGW', isDisabilityFriendly: true);
    final b = PortalCoordinate(45.49735, -73.57918, '1', 'Hall', 'SGW');
    final c = PortalCoordinate(45.49755, -73.57899, '1', 'Hall', 'SGW');
    final d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW');
    final e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW');
    final f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW');
    final x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW');
    final y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW');

    final a2 = PortalCoordinate(45.49719, -73.57933, '2', 'Hall', 'SGW', isDisabilityFriendly: true);
    final b2 = PortalCoordinate(45.49735, -73.57918, '2', 'Hall', 'SGW');
    final c2 = PortalCoordinate(45.49755, -73.57899, '2', 'Hall', 'SGW');

    a.adjCoordinates = {f, b, a, a2};
    b.adjCoordinates = {a, x, c, b2};
    c.adjCoordinates = {b, y, c2};
    d.adjCoordinates = {y, e};
    e.adjCoordinates = {d};
    f.adjCoordinates = {a};
    x.adjCoordinates = {b, y};
    y.adjCoordinates = {c, x, d};

    var floor1 = Floor('1');
    var floor2 = Floor('2');

    floor1.coordinates = {a, b, c, d, e, f, x, y};
    floor2.coordinates = {a, b, c, d, e, f, x, y};
    test('should get all valid exit coordinates, disability = false', () {
      expect(floor1.validExitCoordinates('2'), [a,b,c]);
    });
    test('should get all valid exit coordinates, disability = true', () {
      expect(floor1.validExitCoordinates('2', isDisabilityFriendly: true), [a]);
    });
  });
}