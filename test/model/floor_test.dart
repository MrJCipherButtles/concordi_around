import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/model/floor.dart';
import 'package:concordi_around/model/path.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('shortest path', () {
    var a = Coordinate(45.49719, -73.57933, '1', 'Hall', 'SGW');
    var b = Coordinate(45.49735, -73.57918, '1', 'Hall', 'SGW');
    var c = Coordinate(45.49755, -73.57899, '1', 'Hall', 'SGW');
    var d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW');
    var e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW');
    var f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW');
    var x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW');
    var y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW');
    var z = Coordinate(45.49748, -73.57885, '1', 'Hall', 'SGW');
    var zz = Coordinate(45.49753, -73.57893, '1', 'Hall', 'SGW');

    a.adjCoordinates = {f, b};
    b.adjCoordinates = {a, x, c};
    c.adjCoordinates = {b, y, z, zz};
    d.adjCoordinates = {y, e};
    e.adjCoordinates = {d};
    f.adjCoordinates = {a};
    x.adjCoordinates = {b, y};
    y.adjCoordinates = {c, x, d, z, zz};
    z.adjCoordinates = {c, y};
    zz.adjCoordinates = {c, y};


    var floor = Floor('1');
    floor.coordinates = {a, b, c, d, e, f, x, y, z, zz};
    
    test('shortest path from f to e', () {
      expect(floor.shortestPath(f, e).toString(), Path([f, a, b, c, y, d, e]).toString());
    });
    test('shortest path from a to a', () {
      expect(floor.shortestPath(a, a).length(), closeTo(0, 0.1));
    });
    test('shortest path from z to zz', () {
      expect(floor.shortestPath(z, zz).toString(), Path([z, zz]).toString());
    });
  });
  group('coordinate types', () {
    var a = Coordinate(45.49719, -73.57933, '1', 'Hall', 'SGW', type: 'A');
    var b = Coordinate(45.49735, -73.57918, '1', 'Hall', 'SGW', type: 'B');
    var c = Coordinate(45.49755, -73.57899, '1', 'Hall', 'SGW', type: 'C');
    var d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW', type: 'A');
    var e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW', type: 'B');
    var f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW', type: 'C');
    var x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW', type: 'A');
    var y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW', type: 'B');
    

    a.adjCoordinates = {f,b};
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
    var a = PortalCoordinate(45.49719, -73.57933, '1', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b = PortalCoordinate(45.49735, -73.57918, '1', 'Hall', 'SGW');
    var c = PortalCoordinate(45.49755, -73.57899, '1', 'Hall', 'SGW');
    var d = Coordinate(45.49734, -73.57855, '1', 'Hall', 'SGW');
    var e = Coordinate(45.49714, -73.57875, '1', 'Hall', 'SGW');
    var f = Coordinate(45.49698, -73.57888, '1', 'Hall', 'SGW');
    var x = Coordinate(45.49720, -73.57887, '1', 'Hall', 'SGW');
    var y = Coordinate(45.49741, -73.57868, '1', 'Hall', 'SGW');

    var a2 = PortalCoordinate(45.49719, -73.57933, '2', 'Hall', 'SGW', isDisabilityFriendly: true);
    var b2 = PortalCoordinate(45.49735, -73.57918, '2', 'Hall', 'SGW');
    var c2 = PortalCoordinate(45.49755, -73.57899, '2', 'Hall', 'SGW');

    a.adjCoordinates = {f, b, a2};
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
    floor2.coordinates = {a2, b2, c2};
    test('should get all valid exit coordinates, disability = false', () {
      expect(floor1.validExitCoordinates('2'), [a,b,c]);
    });
    test('should get all valid exit coordinates, disability = true', () {
      expect(floor1.validExitCoordinates('2', isDisabilityFriendly: true), [a]);
    });
  });
}