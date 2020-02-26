import 'dart:collection';

import 'package:concordi_around/models/floor.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
part 'coordinate.jorm.dart';

class Coordinate {
  int id;

  @PrimaryKey()
  double _lat;

  @PrimaryKey()
  double _lng;
  @Column(isNullable: true)
  String _building;
  @Column(isNullable: true)
  String _campus;
  @Column(isNullable: true)
  String _type;
  @Column(isNullable: true)
  bool _isDisabilityFriendly;

  @HasMany(CoordinateBean)
  List<Coordinate> _adjCoordinates;

  @BelongsTo.many(CoordinateBean, refCol: "id", isNullable: true)
  int parentId;

  @BelongsTo(FloorBean, refCol: 'floor', isNullable: true)
  String floor;

  Coordinate(
      {this.id,
      this.parentId,
      lat,
      lng,
      floor,
      building,
      campus,
      type,
      adjCoordinates,
      isDisabilityFriendly}) {
    _type = type;
    _adjCoordinates = adjCoordinates;
    _lat = lat;
    _lng = lng;
    this.floor = floor;
    _building = building;
    _campus = campus;
    _isDisabilityFriendly = _isDisabilityFriendly;
  }

  double get lat => _lat;
  double get lng => _lng;
  String get building => _building;
  String get campus => _campus;
  String get type => _type;
  List<Coordinate> get adjCoordinates => _adjCoordinates;

  //if I am your neighbor, then you must be my neighbor
  void addAdjCoordinate(Coordinate coordinate) {
    _adjCoordinates.add(coordinate);
    coordinate._adjCoordinates.add(this);
  }

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

  @override
  String toString() {
    return 'Coordinate{_lat: $_lat, _lng: $_lng, _adjCoordinates: $_adjCoordinates}';
  }

  
}


@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  CoordinateBean _coordinateBean;
  FloorBean _floorBean;

  CoordinateBean(Adapter adapter) : super(adapter);

  String get tableName => 'coordinate';

  FloorBean get floorBean => _floorBean ??= new FloorBean(adapter);

  @override
  CoordinateBean get coordinateBean {
    _coordinateBean ??= new CoordinateBean(adapter);
    return _coordinateBean;
  }
}
