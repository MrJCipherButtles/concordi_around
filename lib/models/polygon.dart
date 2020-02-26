import 'package:concordi_around/models/coordinate.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

import 'floor.dart';

part 'polygon.jorm.dart';

class Polygon {
  @PrimaryKey(auto: true)
  int id;

  @HasMany(CoordinateBean)
  List<Coordinate> _boundary;

  @BelongsTo(FloorBean, refCol: 'id', isNullable: true)
  int floor;

  Polygon({boundary}) {
    _boundary = boundary;
  }

  @override
  String toString() {
    return 'Polygon{id: $id, _boundary: $_boundary, floor: $floor}';
  }
}

@GenBean()
class PolygonBean extends Bean<Polygon> with _PolygonBean {
  String get tableName => 'polygon';
  final CoordinateBean coordinateBean;
  FloorBean _floorBean;


  PolygonBean(Adapter adapter)
      : coordinateBean = CoordinateBean(adapter),
        super(adapter);

  FloorBean get floorBean => _floorBean ??= new FloorBean(adapter);

}