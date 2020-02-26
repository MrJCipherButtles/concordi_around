import 'dart:collection';
import 'package:concordi_around/models/building.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
import 'package:jaguar_query/jaguar_query.dart';

import 'floor.dart';

part 'coordinate.jorm.dart';
part 'roomcoordinate.jorm.dart';
part 'portalcoordinate.jorm.dart';



abstract class Coordinate {
  @PrimaryKey()
  final double _lat;

  @PrimaryKey()
  final double _lng;

  @Column(isNullable: true)
  @BelongsTo(FloorBean)
  final String _floor;

  @Column(isNullable: true)
  @BelongsTo(BuildingBean)
  final String _building;

  final String _campus;
  
  @Column(isNullable: true)
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

class PortalCoordinate extends Coordinate {


  bool _isDisabilityFriendly;

  PortalCoordinate(lat, lng, floorLevel, building, campus, {type, adjCoordinates, isDisabilityFriendly = false}) :
        super(lat, lng, floorLevel, building, campus, type:type, adjCoordinates:adjCoordinates) {
    _isDisabilityFriendly = isDisabilityFriendly;
  }

  bool get isDisabilityFriendly => _isDisabilityFriendly;

  set isDisabilityFriendly(bool isDisabilityFriendly) => _isDisabilityFriendly = isDisabilityFriendly;
}

class RoomCoordinate extends Coordinate {
  String _roomId;

  RoomCoordinate(lat, lng, floorLevel, building, campus, {type, adjCoordinates, roomId}) :
        super(lat, lng, floorLevel, building, campus, type:type, adjCoordinates:adjCoordinates) {
    _roomId = roomId;
  }

  String get roomId => _roomId;

  set roomId(String roomId) => _roomId = roomId;
}

@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  //FloorBean
  BuildingBean _buildingBean;

  BuildingBean get buildingBean {
    _buildingBean ??= new BuildingBean(adapter);
    return _buildingBean;
  }

  
  FloorBean _floorBean;

  FloorBean get floorBean {
    _floorBean ??= new FloorBean(adapter);
    return _floorBean;
  }



  final String tableName = 'coordinates';
  CoordinateBean(Adapter adapter) : super(adapter);
}



class PortalCoordinateBean extends Bean<PortalCoordinate> with _PortalCoordinateBean {
  //FloorBean

  // BuildingBean _buildingBean;

  // BuildingBean get buildingBean {
  //   _buildingBean ??= new BuildingBean(adapter);
  //   return _buildingBean;
  // }

  
  // FloorBean _floorBean;

  // FloorBean get floorBean {
  //   _floorBean ??= new FloorBean(adapter);
  //   return _floorBean;
  // }



  final String tableName = 'portalcoordinates';
  PortalCoordinateBean(Adapter adapter) : super(adapter);
}

class RoomCoordinateBean extends Bean<RoomCoordinate> with _RoomCoordinateBean {
  //FloorBean

  // BuildingBean _buildingBean;

  // BuildingBean get buildingBean {
  //   _buildingBean ??= new BuildingBean(adapter);
  //   return _buildingBean;
  // }

  
  // FloorBean _floorBean;

  // FloorBean get floorBean {
  //   _floorBean ??= new FloorBean(adapter);
  //   return _floorBean;
  // }



  final String tableName = 'roomcoordinates';
  RoomCoordinateBean(Adapter adapter) : super(adapter);
}
