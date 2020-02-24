import 'Coordinate.dart';

class PortalCoordinate extends Coordinate {

  bool _isDisabilityFriendly;

  PortalCoordinate(lat, lng, floorLevel, building, campus, {type, adjCoordinates, isDisabilityFriendly = false}) : 
  super(lat, lng, floorLevel, building, campus, type:type, adjCoordinates:adjCoordinates) {
    _isDisabilityFriendly = isDisabilityFriendly;
  }

  bool get isDisabilityFriendly => _isDisabilityFriendly;

  set isDisabilityFriendly(bool isDisabilityFriendly) => _isDisabilityFriendly = isDisabilityFriendly;
}
