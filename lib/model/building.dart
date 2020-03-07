import 'dart:collection';

import 'coordinate.dart';
import 'floor.dart';
import 'path.dart';

class Building {
  final String _building;
  List<Coordinate>
      _polygon; //A polygon includes a duplicated point for google maps
  Map<String, Floor> _floors = HashMap<String, Floor>();
  Coordinate _coordinate; //The central coordinate of building

  Building(this._building, {polygon, coordinate}) {
    _polygon = polygon;
    _coordinate = coordinate;
  }

  String get building => _building;
  Coordinate get coordinate => _coordinate;
  List<Coordinate> get polygon => _polygon;
  Map<String, Floor> get floors => _floors;

  set floors(Map<String, Floor> floors) => _floors = floors;
  set polygon(List<Coordinate> polygon) => _polygon = polygon;

  void addFloor(Floor floor) {
    _floors[floor.floor] = floor;
  }

  //Would template method apply here to improve extensibility?
  //May set disability to true using optional named parameter
  //spans at most 2 floors per building
  Map<String, Path> shortestPath(Coordinate s, Coordinate d,
      {bool isDisabilityFriendly = false}) {
    assert(s != null && d != null);
    var indoorNavigationMap = LinkedHashMap<String, Path>();
    var sFloor = _floors[s.floor];
    var dFloor = _floors[d.floor];
    if (sFloor.floor == dFloor.floor) {
      indoorNavigationMap[s.floor] = sFloor.shortestPath(s, d);
      return indoorNavigationMap;
    }
    //How should I get the closest exit/entry coordinates in a
    // more efficient method than below? KTree/Graph method maybe?
    //Get all valid exits
    var exits = sFloor.validExitCoordinates(d.floor,
        isDisabilityFriendly: isDisabilityFriendly);
    //Get all paths to the exits found
    var exitPaths = <Path>[];
    for (var exit in exits) {
      if (s == exit) {
        exitPaths.add(Path(<Coordinate>[s, exit]));
      }
      exitPaths.add(sFloor.shortestPath(s, exit));
    }
    //Get the shortest of all the paths found
    var shortestExitPath = exitPaths[0];
    for (var exitPath in exitPaths) {
      if (exitPath.length() < shortestExitPath.length()) {
        shortestExitPath = exitPath;
      }
    }
    indoorNavigationMap[s.floor] = shortestExitPath;
    //Find the coordinate of the destination floor from the exit found
    var sExitAdjacentExitCoordinates =
        shortestExitPath.segments.last.destination.adjCoordinates;
    var dEntry;
    for (var sExitAdjacentCoordinate in sExitAdjacentExitCoordinates) {
      if (sExitAdjacentCoordinate.floor == dFloor.floor) {
        dEntry = sExitAdjacentCoordinate;
      }
    }
    indoorNavigationMap[d.floor] = dFloor.shortestPath(dEntry, d);
    return indoorNavigationMap;
  }
}
