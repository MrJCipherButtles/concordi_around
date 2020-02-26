import 'package:concordi_around/db/model/floor.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'poi.jorm.dart';

class Poi {

  @PrimaryKey(auto: true)
  int id;

  @Column(isNullable: false)
  int type;

  @BelongsTo(FloorBean)
  int floorId;


  String toString() =>
      'Poi(id: $id, type: $type, floorId: $floorId)';
}

@GenBean()
class PoiBean extends Bean<Poi> with _PoiBean {
  final String tableName = 'poi';
  FloorBean _floorBean;

  PoiBean(Adapter adapter) : super(adapter);

  FloorBean get floorBean => _floorBean ??= new FloorBean(adapter);

}