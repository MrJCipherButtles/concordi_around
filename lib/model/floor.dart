import 'dart:collection';
import 'coordinate.dart';
import 'path.dart';

class Floor {
  /*
  -------ATTRIBUTES-------
  Each polygon on the floor includes a duplicated point for compatibility with Google Maps
  */

  FloorProduct _floorProduct = FloorProduct();
  final String _floorName;
  Set<List<Coordinate>> _polygons = <List<Coordinate>>{}; 

  /*
  -------CONSTRUCTOR-------
   */

  Floor(this._floorName, {coordinates, polygons}) {
    _floorProduct.coordinates = coordinates;
    _polygons = polygons;
  }

  /*
  -------GETTERS AND SETTERS-------
   */

  String get floorName => _floorName;
  Set<List<Coordinate>> get polygons => _polygons;

  set polygons(Set<List<Coordinate>> polygons) => _polygons = polygons;

  /*
  -------PUBLIC METHOD-------
   */
  
  //computes the shortest path
  Path shortestPath(Coordinate s, Coordinate d) {
    assert(s != null && d != null && s.floor == _floorName && d.floor == _floorName);
    //if s and d share the same adjacency coordinates then
    //they must be the same coordinate, or
    //they must be on the same segment
    //A room coordinate must have 2 and only 2 portal coordinates.
    if (s.adjCoordinates.containsAll(d.adjCoordinates)) {
      return Path(<Coordinate>[s, d]);
    }
    return _findShortestPath(_getAllPathsFromSourceToDestination(s, d));
  }

  /*
  -------PRIVATE METHODS-------
   */

  // Returns list of all paths from 's' to 'd'
  static List<Path> _getAllPathsFromSourceToDestination(
      Coordinate s, Coordinate d) {
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
  static void _computePathList(
      Coordinate s,
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
      if (!visitedList.contains(coordinate) &&
          (coordinate is PortalCoordinate || coordinate == d)) {
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

  /*
  -------DELEGATES-------
   */

  Set<Coordinate> get coordinates => _floorProduct._coordinates;

  set coordinates(Set<Coordinate> coordinates) => _floorProduct._coordinates = coordinates;

  List<Coordinate> coordinatesByGivenTypes(Iterable<String> types) {
    return _floorProduct.coordinatesByGivenTypes(types);
  }

  List<Coordinate> validExitCoordinates(String nextFloorName,
      {bool isDisabilityFriendly = false}) {
    return _floorProduct.validExitCoordinates(nextFloorName, isDisabilityFriendly:isDisabilityFriendly);
  }
}

//////////////////////////////////////////////////////////////////

class FloorProduct {
  /*
  -------ATTRIBUTES-------
  */

  Set<Coordinate> _coordinates = HashSet<Coordinate>();

  /*
  -------GETTERS AND SETTERS-------
   */

  Set<Coordinate> get coordinates => _coordinates;

  set coordinates(Set<Coordinate> coordinates) => _coordinates = coordinates;

  /*
  -------PUBLIC METHODS-------
   */

  //returns a customized list of coordinates based on the types wanted
  List<Coordinate> coordinatesByGivenTypes(Iterable<String> types) {
    var subset = <Coordinate>[];
    for (var coordinate in _coordinates ?? {}) {
      for (var type in types) {
        if (coordinate.type == type) {
          subset.add(coordinate);
        }
      }
    }
    return subset;
  }

  //returns valid exit coordinates to the next floor depending on disability (false by default)
  List<Coordinate> validExitCoordinates(String nextFloorName,
      {bool isDisabilityFriendly = false}) {
    var portalCoordinates = <Coordinate>[];
    //From all the coordinates
    for (var coordinate in _coordinates) {
      //We care only about portal coordinates
      if (coordinate is PortalCoordinate) {
        //that can get us to the destination floor.
        for (var adjacentExitCoordinate in coordinate.adjCoordinates) {
          if (adjacentExitCoordinate.floor == nextFloorName) {
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
}
