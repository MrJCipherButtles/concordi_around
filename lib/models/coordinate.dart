import 'dart:collection';

import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
part 'coordinate.jorm.dart';

class Coordinate {
  int id;

  @PrimaryKey()
  double _lat;

  @PrimaryKey()
  double _lng;
  String _floor;
  String _building;
  String _campus;
  String _type;
  bool _isDisabilityFriendly;




  @HasMany(CoordinateBean)
  List<Coordinate> _adjCoordinates;

  @BelongsTo.many(CoordinateBean)
  int parentId;

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
    _floor = floor;
    _building = building;
    _campus = campus;
    _isDisabilityFriendly = _isDisabilityFriendly;
  }

  double get lat => _lat;
  double get lng => _lng;
  String get floor => _floor;
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

  String toString() => this.id.toString();
}


@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  CoordinateBean _coordinateBean;

  CoordinateBean(Adapter adapter) : super(adapter);

  String get tableName => 'coordinate';

  @override
  CoordinateBean get coordinateBean {
    _coordinateBean ??= new CoordinateBean(adapter);
    return _coordinateBean;
  }
}
