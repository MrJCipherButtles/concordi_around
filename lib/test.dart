import 'dart:collection';

import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';
import 'package:concordi_around/Graph.dart';
import 'package:concordi_around/DijkstraAlgorithm.dart';
import 'package:latlong/latlong.dart';



main() {


     List<Vertex> nodes;
     List<Edge> edges;

        Map< String, LatLng> pts = {"A": LatLng(45.49719, -73.57933), "B":LatLng(45.49735, -73.57918), "C":LatLng(45.49735, -73.57918), "D": LatLng(45.49698, -73.57888)} ;
        nodes = new List<Vertex>();
        edges = new List<Edge>();




        pts.forEach((k,v) => (
          nodes.add(new Vertex("Node_" + k, "Node_" + k.toString(), v)))); 
        
        
       


       

          void addLane(String laneId, int sourceLocNo, int destLocNo,
            int duration) {
        Edge lane = new Edge(laneId,nodes[sourceLocNo], nodes[destLocNo], duration );
        edges.add(lane);
    }
        addLane("Edge_0", 0, 1, 5);
        addLane("Edge_1", 0, 3, 8);

        addLane("Edge_0", 1, 0, 5);
        addLane("Edge_0", 1, 2, 5);
        addLane("Edge_2", 2, 1, 4);

        addLane("Edge_2", 3, 0, 4);


    

    
      

        // Lets check from location Loc_1 to Loc_10
        Graph graph = new Graph(nodes, edges);
        DijkstraAlgorithm dijkstra = new DijkstraAlgorithm(graph);
        dijkstra.execute(nodes[2]);
        LinkedList<Vertex> path = dijkstra.getPath(nodes[3]);
        var lst = path.toList().reversed;

      

        for (Vertex vertex in lst) {
            print(vertex.toString());
        }

    }

    