import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';
import 'package:jaguar_orm/jaguar_orm.dart';

part 'Graph.jorm.dart';

class Graph {
  @PrimaryKey(auto: true)
  int id;

  @HasMany(VertexBean)
  List<Vertex> vertexes;

  @HasMany(EdgeBean)
  List<Edge> edges;

  Graph({this.vertexes, this.edges});

  List<Vertex> getVertexes() {
    return vertexes;
  }

  List<Edge> getEdges() {
    return edges;
  }
}

@GenBean()
class GraphBean extends Bean<Graph> with _GraphBean {
  String get tableName => 'edge';
  final VertexBean vertexBean;
  final EdgeBean edgeBean;

  GraphBean(Adapter adapter )
      : vertexBean = VertexBean(adapter),
        edgeBean = EdgeBean(adapter),
        super(adapter);
}