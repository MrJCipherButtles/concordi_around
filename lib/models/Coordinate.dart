import 'dart:collection';

abstract class Coordinate {
  final double _lat;
  final double _lng;
  final String _floorLevel;
  final String _building;
  final String _campus;
  String _type;
  Set<Coordinate> _adjCoordinates = HashSet<Coordinate>();

  Coordinate(this._lat, this._lng, this._floorLevel, this._building, this._campus, {type, adjCoordinates}) {
    _type = type;
    _adjCoordinates = adjCoordinates;
  }

  double get lat => _lat;
  double get lng => _lng;
  String get floorLevel => _floorLevel;
  String get building => _building;
  String get campus => _campus;
  String get type => _type;
  Set<Coordinate> get adjCoordinates => _adjCoordinates;

  set type(String type) => _type = type;
  set adjCoordinates(Set<Coordinate> adjCoordinates) => _adjCoordinates = adjCoordinates;

  bool addAdjCoordinate(Coordinate coordinate) => _adjCoordinates.add(coordinate) && coordinate._adjCoordinates.add(this);

  // Might want to define a better toString...
  @override
  String toString() => _type;
}
