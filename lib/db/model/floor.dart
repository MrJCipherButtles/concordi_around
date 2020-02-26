import 'package:concordi_around/db/model/poi.dart';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'floor.jorm.dart';

class Floor {

  @Column(isNullable: false)
  int level;

  @HasMany(PoiBean)
  List<Poi> pois;

  static const String tableName = 'floor';

  String toString() =>
      'Floor(id: $id, level: $level, poi: $pois)';
}


@GenBean()
class FloorBean extends Bean<Floor> with _FloorBean {
  final String tableName = 'floors';

  final PoiBean poiBean;

  FloorBean(Adapter adapter)
      : poiBean = new PoiBean(adapter),
        super(adapter);
}