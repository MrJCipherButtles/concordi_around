import 'dart:collection';
import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';
import 'package:concordi_around/Graph.dart';
import 'package:concordi_around/DijkstraAlgorithm.dart';
import 'dart:math';
import 'package:kdtree/kdtree.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong/latlong.dart';

// main(){
// var start = LatLng(45.49707, -73.57906);
// var end = LatLng(45.49748, -73.57905);
// List<LatLng> latlng = new Path().getPath(start, end);

// // latlng.forEach((element) => {print(element)});
// }

class Path {
  List<Vertex> nodes = new List<Vertex>();
  List<Edge> edges = new List<Edge>();
  Map<String, LatLng> pts = {
    "a": LatLng(45.49719, -73.57933),
    "b": LatLng(45.49735, -73.57918),
    "c": LatLng(45.49755, -73.57899),
    "y": LatLng(45.49741, -73.57868),
    "d": LatLng(45.49734, -73.57855),
    "e": LatLng(45.49714, -73.57875),
    "x": LatLng(45.4972, -73.57887),
    "f": LatLng(45.49698, -73.57888)

  };

 void addLane(String laneId, int sourceLocNo, int destLocNo,
            int duration) {
        LatLng source = nodes[sourceLocNo].point;
        LatLng dest = nodes[destLocNo].point;

        List<LatLng> ptsinBetween = getPoints(source, dest);
        var prevNode = nodes[sourceLocNo]; 
        for(int i=0; i<ptsinBetween.length ; i++){
          
          if(i==ptsinBetween.length -1){
          // nodes.add(new Vertex(nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), ptsinBetween[i]));
          edges.add(new Edge(laneId,prevNode, nodes[destLocNo], 1 ));
          edges.add(new Edge(laneId,nodes[destLocNo], prevNode, 1 ));
          break;
          }
          nodes.add(new Vertex(nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), ptsinBetween[i]));
          edges.add(new Edge(laneId,prevNode, nodes[nodes.length-1], 1 ));
          edges.add(new Edge(laneId,nodes[nodes.length-1], prevNode, 1 ));
          prevNode = nodes[nodes.length-1];

        } 

                


              
    }

    getJunctionAsVertex(String junction, Map<String, LatLng>  pts){
      var count = 0;

      var keys = pts.keys;

      for(var key in keys){
        if(key!= junction)
        count++;
        else
        break;
      }

      return count;
    }

  List<LatLng> getPath(LatLng ast, LatLng bend) {
    var start = ast;
    var end = bend;


    var a = getJunctionAsVertex("a", pts);
    var b = getJunctionAsVertex("b", pts);
    var c = getJunctionAsVertex("c", pts);
    var d = getJunctionAsVertex("d", pts);
    var e = getJunctionAsVertex("e", pts);
    var f = getJunctionAsVertex("f", pts);
    var x = getJunctionAsVertex("x", pts);
    var y = getJunctionAsVertex("y", pts);



     pts.forEach((k,v) => (
          nodes.add(new Vertex(id: k, k.toString(), v))));

   
        

        addLane("Edge_0", a, b, 4);
        addLane("Edge_1", a, f, 8);
        addLane("Edge_0", b, c, 6);
        addLane("Edge_0", b, x, 6);
        addLane("Edge_0", c, y, 5);
        addLane("Edge_0", y, x, 6);
        addLane("Edge_0", y, d, 2);
        addLane("Edge_0", d, e, 6);
        addLane("Edge_0", e, x, 2);
        addLane("Edge_0", e, f, 4);

       
     

    //find closest point for start

    List<Map<String, double>> junctionPointsinKDFormat =
        convertListToKDFormat(nodes);
    var distance = (a, b) {
      return sqrt(pow(a['x'] - b['x'], 2) + pow(a['y'] - b['y'], 2));
    };

    var tree = KDTree(junctionPointsinKDFormat, distance, ['x', 'y']);

    var closestStartJunction =
        convertKDRetToOnePoint(tree.nearest({'x': start.latitude, 'y': start.longitude}, 1));
    var closestEndJunction =
        convertKDRetToOnePoint(tree.nearest({'x': end.latitude, 'y': end.longitude}, 1));
      

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

        // lst.forEach((element) => {print(element)});

        List<LatLng> ret = [];
        for(var item in lst){
          ret.add(item.point);
        }

        // ret[0] = start;
        // ret[ret.length-1] = end;
        return ret;
        
  }

  List<Map<String, double>> convertMapToKDFormat(Map<String, LatLng> map) {
    List<Map<String, double>> ret = [];
    map.forEach((k, v) => (ret.add({'x': v.latitude, 'y': v.longitude})));

    return ret;
  }

  List<Map<String, double>> convertListToKDFormat(List<Vertex> lst){
    List<Map<String, double>> ret = [];
    lst.forEach((element) => (ret.add({'x': element.point.latitude, 'y': element.point.longitude})));

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

    double interval = ((b.latitude - a.latitude) / 200);

    double begin = a.latitude;
    for (int i = 0; i <= 200; i++) {
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
