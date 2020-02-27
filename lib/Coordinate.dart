import 'dart:async';
import 'dart:html';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

import 'Vertex.dart';


part 'Coordinate.jorm.dart';


class Coordinate {
  @PrimaryKey(auto: true)
  int id;

  double lat;
  double long;

  @BelongsTo(VertexBean, refCol: 'id')
  int vertexId;

  Coordinate({this.id, this.lat, this.long, this.vertexId});

  String toString() => "Address($id, $vertexId, $lat, $long)";

  bool operator ==(final other) {
    if (other is Coordinate)
      return id == other.id && lat == other.lat && long == other.long  && vertexId == other.vertexId;
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}

@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  CoordinateBean(Adapter adapter) : super(adapter);


  String get tableName => 'oto_simple_address';
}