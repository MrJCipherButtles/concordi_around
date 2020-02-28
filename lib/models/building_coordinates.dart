import 'building.dart';
import 'coordinate.dart';
import 'floor.dart';

class BuildingSingleton {
  static final BuildingSingleton _instance = BuildingSingleton._internal();

  Building _building;

  factory BuildingSingleton() {
    return _instance;
  }

  BuildingSingleton._internal() {

    PortalCoordinate a = PortalCoordinate(
        45.49719, -73.57933, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate b = PortalCoordinate(
        45.49734, -73.57918, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate start = RoomCoordinate(
        45.49713, -73.57919, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate end = RoomCoordinate(45.49749, -73.57905, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    a.addAdjCoordinate(start);
    a.addAdjCoordinate(b);
    b.addAdjCoordinate(end);

    Floor eigth_floor = Floor('8', coordinates: {a, b, start, end});

    _building = Building('Hall', floors: {'8': eigth_floor});
  }

  Building get building => _building;
}