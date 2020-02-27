
import 'dart:collection';

import 'coordinate.dart';
import 'path.dart';

class Floor {
  final String _floor;
  Set<List<Coordinate>> _polygons = <List<Coordinate>>{}; //A polygon includes a duplicated point for google maps
  Set<Coordinate> _coordinates = HashSet<Coordinate>();

  Floor(this._floor, {coordinates, polygons}) {
    _coordinates = coordinates;
    _polygons = polygons;
  }

  String get floor => _floor;
  Set<List<Coordinate>> get polygons => _polygons;
  Set<Coordinate> get coordinates => _coordinates;

  set polygons(Set<List<Coordinate>> polygons) => _polygons = polygons;
  set coordinates(Set<Coordinate> coordinates) => _coordinates = coordinates;

  //returns a customized list of coordinates based on the types wanted
  List<Coordinate> coordinatesByGivenTypes(Iterable<String> types) {
    var subset = <Coordinate>[];
    for (var coordinate in _coordinates) {
      for (var type in types) {
        if (coordinate.type == type) {
          subset.add(coordinate);
        }
      }
    }
    return subset;
  }

  //returns valid exit coordinates to the next floor depending on disability
  //The disability default is false
  List<Coordinate> validExitCoordinates(String nextFloor, {bool isDisabilityFriendly = false}) {
    var portalCoordinates = <Coordinate>[];
    //From all the coordinates
    for (var coordinate in _coordinates) {
      //We care only about portal coordinates
      if (coordinate is PortalCoordinate) {
        //that can get us to the destination floor.
        for (var adjacentExitCoordinate in coordinate.adjCoordinates) {
          if (adjacentExitCoordinate.floor == nextFloor) {
            //If disability is true
            if (isDisabilityFriendly) {
              //Add the exits that are disability-friendly
              if (coordinate.isDisabilityFriendly) {
                portalCoordinates.add(coordinate);
              }
            }
            //If disability is false
            else {
              //Add all exits
              portalCoordinates.add(coordinate);
            }
          }
        }
      }
    }
    return portalCoordinates;
  }

  //...Should we add more specialized filter methods such as the 2 above,
  //...Should we provide singular add methods for _polygons and _coordinates?

  // Returns list of all paths from 's' to 'd'
  static List<Path> _getAllPathsFromSourceToDestination(Coordinate s, Coordinate d) {
    var visitedList = <Coordinate>[];
    var coordinateList = <Coordinate>[];
    var pathList = <Path>[];
    //add a source to path list
    coordinateList.add(s);
    //Call recursive utility
    _computePathList(s, d, visitedList, coordinateList, pathList);
    return pathList;
  }

  // A recursive function to find all paths from 's' to 'd'.
  // visitedList keeps track of coordinates in the current path.
  // coordinateList stores actual coordinates in the current path
  // pathList stores every valid path
  static void _computePathList(Coordinate s,
      Coordinate d,
      List<Coordinate> visitedList,
      List<Coordinate> coordinateList,
      List<Path> pathList) {
    visitedList.add(s); // Mark the current coordinate visited
    if (s == d) {
      pathList.add(Path(coordinateList));
      // if match found then no need to traverse more till depth
      visitedList.remove(s);
      return;
    }
    // Recur for all the coordinates
    // adjacent to current coordinate
    for (var coordinate in s.adjCoordinates) {
      if (!visitedList.contains(coordinate)) {
        // store current coordinate
        // in path list
        coordinateList.add(coordinate);
        _computePathList(coordinate, d, visitedList, coordinateList, pathList);
        // remove current coordinate
        // in path list
        coordinateList.remove(coordinate);
      }
    }
    //Mark the current coordinate unvisited
    visitedList.remove(s);
  }

  //returns the shortest path
  Path shortestPath(Coordinate s, Coordinate d) {
    assert (s != null && d != null && s.floor == _floor && d.floor == _floor);
    //if s and d share the same adjacency coordinates then
    //they must be the same coordinate, or
    //they must be on the same segment
    //A room coordinate must have 2 and only 2 portal coordinates.
    if (s.adjCoordinates == d.adjCoordinates) {
      return Path(<Coordinate>[s, d]);
    }
    return _findShortestPath(_getAllPathsFromSourceToDestination(s, d));
  }

  //finds the shortest path
  static Path _findShortestPath(List<Path> pathList) {
    var shortestPath = pathList[0];
    for (var path in pathList) {
      if (path.length() < shortestPath.length()) {
        shortestPath = path;
      }
    }
    return shortestPath;
  }
}
