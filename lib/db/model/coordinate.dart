import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'coordinate.jorm.dart';

class Coordinate {
  Coordinate();

  Coordinate.make(this.id, this.lat, this.lng);

  @PrimaryKey()
  int id;

  @Column(isNullable: true)
  double lat;

  @Column(isNullable: true)
  double lng;

  String toString() =>
      'Coordinate(id: $id, lat: $lat, long: $lng)';
}

@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  CoordinateBean(Adapter adapter) : super(adapter);

  final String tableName = 'coordinates';
}