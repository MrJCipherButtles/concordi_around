import 'package:concordi_around/models/floor.dart';
import 'package:concordi_around/models/polygon.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'coordinate.jorm.dart';

class Coordinate {
  @PrimaryKey(auto: true)
  int id;
  double _lat;
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

  @BelongsTo.many(CoordinateBean, refCol: 'id', isNullable: true)
  int parentId;

  @BelongsTo(FloorBean, refCol: 'id', isNullable: true)
  int floor;

  @BelongsTo(PolygonBean, refCol: 'id', isNullable: true)
  int polygon;

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
  bool get isDisabilityFriendly => _isDisabilityFriendly;
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
    return 'Coordinate{id: $id, _lat: $_lat, _lng: $_lng, _building: $_building, _campus: $_campus, _type: $_type, _isDisabilityFriendly: $_isDisabilityFriendly, _adjCoordinates: $_adjCoordinates, parentId: $parentId, floor: $floor}';
  }
}


@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  String get tableName => 'coordinate';
  CoordinateBean _coordinateBean;
  FloorBean _floorBean;
  PolygonBean _polygonBean;

  CoordinateBean(Adapter adapter) : super(adapter);

  FloorBean get floorBean => _floorBean ??= new FloorBean(adapter);
  CoordinateBean get coordinateBean => _coordinateBean ??= new CoordinateBean(adapter);
  PolygonBean get polygonBean => _polygonBean ??= new PolygonBean(adapter);

}
