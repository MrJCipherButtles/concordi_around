import 'dart:collection';
import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';
import 'package:concordi_around/Graph.dart';
import 'package:concordi_around/DijkstraAlgorithm.dart';
import 'dart:math';
import 'package:kdtree/kdtree.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong/latlong.dart';

class Path {
  List<Vertex> nodes = new List<Vertex>();
  List<Edge> edges = new List<Edge>();
  Map<String, LatLng> pts = {
    "A": LatLng(45.49719, -73.57933),
    "B": LatLng(45.49735, -73.57918),
    "C": LatLng(45.49735, -73.57918),
    "D": LatLng(45.49698, -73.57888)
  };

  List<LatLng> getPath(LatLng a, LatLng b) {
    var start = a;
    var end = b;

    //find closest junction for start

    List<Map<String, double>> junctionPointsinKDFormat =
        convertMapToKDFormat(pts);
    var distance = (a, b) {
      return sqrt(pow(a['x'] - b['x'], 2) + pow(a['y'] - b['y'], 2));
    };

    var tree = KDTree(junctionPointsinKDFormat, distance, ['x', 'y']);

    var closestStartJunction =
        convertKDRetToOnePoint(tree.nearest({'x': start.latitude, 'y': start.longitude}, 1));
    var closestEndJunction =
        convertKDRetToOnePoint(tree.nearest({'x': end.latitude, 'y': end.longitude}, 1));

    pts.forEach((k,v) => (
          nodes.add(new Vertex(k, k.toString(), v)))); 

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
        var startNode;
        var endNode;

        var count = 0;

        for(var item in nodes ){
          if(item.point == closestStartJunction){
            startNode = count;
          }

          if(item.point == closestEndJunction){
            endNode = count;
          }
          count++;
        }

        dijkstra.execute(nodes[startNode]);
        LinkedList<Vertex> path = dijkstra.getPath(nodes[endNode]);
        var lst = path.toList().reversed;
        List<LatLng> ret = [];
        for(var item in lst){
          ret.add(item.point);
        }

        ret[0] = start;
        ret[ret.length-1] = end;
        return ret;
        
  }

  List<Map<String, double>> convertMapToKDFormat(Map<String, LatLng> map) {
    List<Map<String, double>> ret = [];
    map.forEach((k, v) => (ret.add({'x': v.latitude, 'y': v.longitude})));

    return ret;
  }

  LatLng convertKDRetToOnePoint(List<dynamic> kdRet) {
    var point = kdRet[0][0];
    var ret = new LatLng(point['x'], point['y']);
    return ret;
  }

  //get all points in straight line in between a and b  in normal format
  List<LatLng> getPoints(LatLng a, LatLng b) {
    List<LatLng> ret = [];
    List<double> equation = lineFromPoints(a, b);

    double interval = ((b.latitude - a.latitude) / 6);

    double begin = a.latitude;
    for (int i = 0; i <= 6; i++) {
      var lat = begin;
      var long = equation[0] * lat + equation[1];
      ret.add(LatLng(lat, long));
      begin += interval;
    }

    return ret;
  }

  //get all points in straight line in between a and b  in kdtree format
  List<Map<String, double>> getPointsKD(LatLng a, LatLng b) {
    List<LatLng> ret = [];
    List<Map<String, double>> ret2 = [];
    List<double> equation = lineFromPoints(a, b);

    double interval = ((b.latitude - a.latitude) / 6);

    double begin = a.latitude;
    for (int i = 0; i <= 6; i++) {
      var lat = begin;
      var long = equation[0] * lat + equation[1];
      ret.add(LatLng(lat, long));
      ret2.add({'x': lat, 'y': long});
      begin += interval;
    }

    return ret2;
  }

//y = mx + b from two points and returns list containing m and b
  List<double> lineFromPoints(LatLng p1, LatLng p2) {
    List<double> equation = [];
    double deltaY = p2.longitude - p1.longitude;
    double deltaX = p2.latitude - p1.latitude;
    double m = deltaY / deltaX;
    double b = p1.longitude - (m * p1.latitude);

    equation.add(m);
    equation.add(b);
    return equation;
  }

  List<LatLng> pointsFromListMap(List<dynamic> list) {
    List<LatLng> ret = [];

    for (int i = 0; i < list.length; i++) {
      ret.add(LatLng(list[i][0]['x'], list[i][0]['y']));
    }

    return ret;
  }
}
