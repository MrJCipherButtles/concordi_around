import 'dart:collection';

abstract class Coordinate {
  final double _lat;
  final double _lng;
  final String _floor;
  final String _building;
  final String _campus;
  String _type;
  Set<Coordinate> _adjCoordinates = HashSet<Coordinate>();

  Coordinate(this._lat, this._lng, this._floor, this._building, this._campus, {type, adjCoordinates}) {
    _type = type;
    _adjCoordinates = adjCoordinates;
  }

  double get lat => _lat;
  double get lng => _lng;
  String get floor => _floor;
  String get building => _building;
  String get campus => _campus;
  String get type => _type;
  Set<Coordinate> get adjCoordinates => _adjCoordinates;

  set type(String type) => _type = type;
  set adjCoordinates(Set<Coordinate> adjCoordinates) => _adjCoordinates = adjCoordinates;

  //if I am your neighbor, then you must be my neighbor
  bool addAdjCoordinate(Coordinate coordinate) => _adjCoordinates.add(coordinate) && coordinate._adjCoordinates.add(this);

  bool isAdjacent(Coordinate anotherCoordinate) {
    //A coordinate is adjacent to itself
    if (this == anotherCoordinate) {
      return true;
    }
    //Check adjacency list
    for (var adjCoordinate in _adjCoordinates) {
      if (adjCoordinate == anotherCoordinate) {
        //In adjacency list
        return true;
      }
    }
    //Not in adjacency list
    return false;
  }

  // Might want to define a better toString...
  @override
  String toString() => _type;
}
