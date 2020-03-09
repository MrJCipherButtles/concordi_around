import 'dart:collection';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class Coordinate {
  final double _lat;
  final double _lng;
  final String _floor;
  final String _building;
  final String _campus;
  String _type;
  Set<Coordinate> _adjCoordinates = HashSet<Coordinate>();

  Coordinate(this._lat, this._lng, this._floor, this._building, this._campus,
      {type, adjCoordinates}) {
    _type = type;
    if (adjCoordinates != null) {
      _adjCoordinates = adjCoordinates;
      for (var adjCoordinate in _adjCoordinates) {
        adjCoordinate.addAdjCoordinate(this);
      }
    }
  }

  double get lat => _lat;
  double get lng => _lng;
  String get floor => _floor;
  String get building => _building;
  String get campus => _campus;
  String get type => _type;
  Set<Coordinate> get adjCoordinates => _adjCoordinates;

  set type(String type) => _type = type;
  set adjCoordinates(Set<Coordinate> adjCoordinates) =>
      _adjCoordinates = adjCoordinates;

  //if I am your neighbor, then you must be my neighbor
  bool addAdjCoordinate(Coordinate coordinate) =>
      _adjCoordinates.add(coordinate) && coordinate._adjCoordinates.add(this);

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

  LatLng toLatLng() {
    return LatLng(_lat, _lng);
  }

  // Might want to define a better toString...
  @override
  String toString() => '$_lat,$_lng,$_floor';
}

class PortalCoordinate extends Coordinate {
  bool _isDisabilityFriendly;

  PortalCoordinate(lat, lng, floorLevel, building, campus,
      {type, adjCoordinates, isDisabilityFriendly = false})
      : super(lat, lng, floorLevel, building, campus,
            type: type, adjCoordinates: adjCoordinates) {
    _isDisabilityFriendly = isDisabilityFriendly;
  }

  bool get isDisabilityFriendly => _isDisabilityFriendly;

  set isDisabilityFriendly(bool isDisabilityFriendly) =>
      _isDisabilityFriendly = isDisabilityFriendly;
}

class RoomCoordinate extends Coordinate {
  String _roomId;

  RoomCoordinate(lat, lng, floorLevel, building, campus,
      {type, adjCoordinates, roomId})
      : super(lat, lng, floorLevel, building, campus,
            type: type, adjCoordinates: adjCoordinates) {
    _roomId = roomId;
  }

  String get roomId => _roomId;

  set roomId(String roomId) => _roomId = roomId;

  Place toPlace() {
    return Place(_roomId, _roomId);
  }
}
