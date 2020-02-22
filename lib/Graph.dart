import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';

class Graph {
     final List<Vertex> vertexes;
     final List<Edge> edges;

     Graph(this.vertexes, this.edges) {
       
    }

     List<Vertex> getVertexes() {
        return vertexes;
    }

     List<Edge> getEdges() {
        return edges;
    }



}