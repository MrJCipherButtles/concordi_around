
import 'Coordinate.dart';
import 'Path.dart';

class Floor {
  final String _floorLevel;
  //final Set<Coordinate> _polygon = <Coordinate>{};
  Path _path;
  Floor(this._floorLevel);

  Path get path => _path;
  String get floorLevel => _floorLevel;

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

  // A recursive function to find
  // all paths from 's' to 'd'.
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
    // Mark the current coordinate unvisited
    visitedList.remove(s);
  }

  // It may be better to return a stack of floors with
  // the shortest path or disability path for each floor
  void shortestPath(Coordinate s, Coordinate d) {
    assert (s.floorLevel == _floorLevel && d.floorLevel == _floorLevel);
    _path = _findShortestPath(_getAllPathsFromSourceToDestination(s, d));
  }

  // Returns the shortest path
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
