import 'package:concordi_around/Vertex.dart';
import 'package:flutter/material.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'Edge.jorm.dart';

class Edge  {

  @PrimaryKey(auto: true)
  int id;

  @HasOne(VertexBean)
  Vertex source;

  @HasOne(VertexBean)
  Vertex destination;

  int weight;

  Edge({this.id, this.source, this.destination, this.weight});


  Vertex getDestination() {
    return destination;
  }

  Vertex getSource() {
    return source;
  }
  int getWeight() {
    return weight;
  }

  String toString() {
    return source.toString() + " " + destination.toString();
  }

}

@GenBean()
class EdgeBean extends Bean<Edge> with _EdgeBean {
  String get tableName => 'edge';
  final VertexBean vertexBean;

  EdgeBean(Adapter adapter )
      : vertexBean = VertexBean(adapter),
        super(adapter);
}