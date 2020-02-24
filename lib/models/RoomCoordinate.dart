import 'Coordinate.dart';

class RoomCoordinate extends Coordinate {
  String _roomId;

  RoomCoordinate(lat, lng, floorLevel, building, campus, {type, adjCoordinates, roomId}) : 
  super(lat, lng, floorLevel, building, campus, type:type, adjCoordinates:adjCoordinates) {
    _roomId = roomId;
  }

  String get roomId => _roomId;

  set roomId(String roomId) => _roomId = roomId;
}
