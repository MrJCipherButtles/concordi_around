 import 'package:concordi_around/Vertex.dart';

class Edge  {
     final String id;
     final Vertex source;
     final Vertex destination;
     final int weight;

     Edge(this.id, this.source, this.destination, this.weight);
        
    

     String getId() {
        return id;
    }
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