import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinate {
  /*
  -------ATTRIBUTES-------
  */

  final double _lat;
  final double _lng;
  final String _floor;
  final String _building;
  final String _campus;
  String _type;
  Set<Coordinate> _adjCoordinates = HashSet<Coordinate>();

  /*
  -------CONSTRUCTOR-------
   */

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

  /*
  -------GETTERS AND SETTERS-------
   */

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

  /*
  -------PUBLIC METHODS-------
   */

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
  String toString() => '$_building';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinate &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng &&
          floor == other.floor &&
          building == other.building &&
          campus == other.campus &&
          type == other.type &&
          adjCoordinates.containsAll(other.adjCoordinates) &&
          other.adjCoordinates.containsAll(adjCoordinates);

  @override
  int get hashCode => toString().hashCode;
}

//////////////////////////////////////////////////////////////////

class PortalCoordinate extends Coordinate {
  /*
  -------ATTRIBUTE-------
  */

  bool _isDisabilityFriendly;

  /*
  -------CONSTRUCTOR-------
   */

  PortalCoordinate(lat, lng, floorLevel, building, campus,
      {type, adjCoordinates, isDisabilityFriendly = false})
      : super(lat, lng, floorLevel, building, campus,
            type: type, adjCoordinates: adjCoordinates) {
    _isDisabilityFriendly = isDisabilityFriendly;
  }

  /*
  -------GETTERS AND SETTERS-------
   */

  bool get isDisabilityFriendly => _isDisabilityFriendly;

  set isDisabilityFriendly(bool isDisabilityFriendly) =>
      _isDisabilityFriendly = isDisabilityFriendly;
}

//////////////////////////////////////////////////////////////////

class RoomCoordinate extends Coordinate {
  /*
  -------ATTRIBUTE-------
  */

  String _roomId;

  /*
  -------CONSTRUCTOR-------
   */

  RoomCoordinate(lat, lng, floorLevel, building, campus,
      {type, adjCoordinates, roomId})
      : super(lat, lng, floorLevel, building, campus,
            type: type, adjCoordinates: adjCoordinates) {
    _roomId = roomId;
  }

  /*
  -------GETTERS AND SETTERS-------
   */

  String get roomId => _roomId;

  set roomId(String roomId) => _roomId = roomId;

  /*
  -------PUBLIC METHOD-------
   */

  @override
  String toString() => '$roomId';
}

//////////////////////////////////////////////////////////////////

class PlaceCoordinate extends Coordinate {
  /*
  -------ATTRIBUTES-------
  */

  final String _gPlaceAddress;
  final String _gPlacePhone;
  final String _gPlaceWebsite;
  final bool _gPlaceOpenClosed;
  final List<String> _gPlacePictures;

  /*
  -------CONSTRUCTOR-------
   */

  PlaceCoordinate(
      lat,
      lng,
      floorLevel,
      building,
      campus,
      this._gPlaceAddress,
      this._gPlacePhone,
      this._gPlaceWebsite,
      this._gPlaceOpenClosed,
      this._gPlacePictures,
      {type,
      adjCoordinates})
      : super(lat, lng, floorLevel, building, campus,
            type: type, adjCoordinates: adjCoordinates);

  /*
  -------GETTERS-------
   */

  String get gPlaceAddress => _gPlaceAddress;
  String get gPlacePhone => _gPlacePhone;
  String get gPlaceWebsite => _gPlaceWebsite;
  bool get gPlaceOpenClosed => _gPlaceOpenClosed;
  List<String> get gPlacePictures => _gPlacePictures;
}
