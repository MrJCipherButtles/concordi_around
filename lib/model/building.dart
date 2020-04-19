import 'dart:collection';
import 'coordinate.dart';
import 'floor.dart';
import 'path.dart';

class Building {
  /*
  -------ATTRIBUTES-------
  The building's polygon includes a duplicated point for compatibility with Google Maps
  The building's placeId refers to a Google map place ID
  The building's coordinate is the location of the building
  */

  final String _buildingName;
  List<Coordinate> _polygon;
  Map<String, Floor> _floors = HashMap<String, Floor>();
  String _placeId;
  Coordinate _coordinate;

  /*
  -------CONSTRUCTOR-------
   */

  Building(this._buildingName, {polygon, coordinate, placeId}) {
    _polygon = polygon;
    _coordinate = coordinate;
    _placeId = placeId;
  }

  /*
  -------GETTERS AND SETTERS-------
   */

  String get buildingName => _buildingName;
  String get placeId => _placeId;
  Coordinate get coordinate => _coordinate;
  List<Coordinate> get polygon => _polygon;
  Map<String, Floor> get floors => _floors;

  set floors(Map<String, Floor> floors) => _floors = floors;
  set polygon(List<Coordinate> polygon) => _polygon = polygon;

  void addFloor(Floor floor) {
    _floors[floor.floorName] = floor;
  }

  /*
  -------PUBLIC METHOD-------
   */

  //the shortest path spans at most 2 floors, and you can
  //set isDisabilityFriendly named parameter to true for a disability path
  Map<String, Path> shortestPath(Coordinate startCoordinate, Coordinate finishCoordinate, {bool isDisabilityFriendly = false}) {
    //check inputs for nulls
    if (startCoordinate == null || finishCoordinate == null){
      return null;
    }

    var indoorNavigationMap = <String, Path>{};
    final startFloor = _floors[startCoordinate.floor];
    final finishFloor = _floors[finishCoordinate.floor];

    //-------If start and finish are on the same floor-------

    if (startFloor.floorName == finishFloor.floorName) {
      indoorNavigationMap[startCoordinate.floor] = startFloor.shortestPath(startCoordinate, finishCoordinate);
      return indoorNavigationMap;
    }

    //-------Else-------

    //Get all valid exits on start floor
    var startFloorExits = startFloor.validExitCoordinates(finishCoordinate.floor, isDisabilityFriendly: isDisabilityFriendly);

    //Get all paths for every exit found on start floor
    var exitPaths = <Path>[];
    for (var startFloorExit in startFloorExits) {
      if (startCoordinate == startFloorExit) {
        exitPaths.add(Path(<Coordinate>[startCoordinate, startFloorExit]));
      }
      exitPaths.add(startFloor.shortestPath(startCoordinate, startFloorExit));
    }

    //Get the shortest path from start coordinate to an exit on start floor
    final shortestStartToExitPath = _shortestExitPath(exitPaths);

    //Find entrance to finish floor from the exit taken on start floor based on the shortest path found
    final destinationFloorEntrance = _getDestinationEntranceCoordinate(finishCoordinate.floor, shortestStartToExitPath);

    //Get the shortest path from finish floor entrance to finish coordinate
    final shortestEntranceToFinishPath = finishFloor.shortestPath(destinationFloorEntrance, finishCoordinate);
    
    //Complete the navigation map
    indoorNavigationMap[startCoordinate.floor] = shortestStartToExitPath;
    indoorNavigationMap[finishCoordinate.floor] = shortestEntranceToFinishPath;

    //Return the navigation map
    return indoorNavigationMap;
  }

  /*
  -------PRIVATE METHODS-------
   */

  Coordinate _getDestinationEntranceCoordinate(String destinationFloorName, Path exitPath) {
    final exitAdjacentCoordinates = exitPath.segments.last.destination.adjCoordinates;
    for (var exitAdjacentCoordinate in exitAdjacentCoordinates) {
      if (exitAdjacentCoordinate.floor == destinationFloorName) {
        return exitAdjacentCoordinate;
      }
    }
    return null;
  }

  Path _shortestExitPath(List<Path> exitPaths) {
    var shortestExitPath = exitPaths[0];
    for (Path exitPath in exitPaths) {
      if (exitPath.length() < shortestExitPath.length()) {
        shortestExitPath = exitPath;
      }
    }
    return shortestExitPath;
  }
}
