import 'dart:collection';
import 'package:concordi_around/Coordinate.dart';
import 'package:concordi_around/Edge.dart';
import 'package:concordi_around/Vertex.dart';
import 'package:concordi_around/Graph.dart';
import 'package:concordi_around/DijkstraAlgorithm.dart';
import 'dart:math';
import 'package:kdtree/kdtree.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong/latlong.dart';

// main(){
// var start = Coordinate(lat: 45.49707, long:-73.57906);
// var end = Coordinate(lat: 45.49748, long: -73.57905);
// List<Coordinate> latlng = new Path().getPath(start, end);

// // latlng.forEach((element) => {print(element)});
// }


class Path {
  List<Vertex> nodes = new List<Vertex>();
  List<Edge> edges = new List<Edge>();
  Map<String, Coordinate> pts = {
    "a": Coordinate(lat:45.49719, long: -73.57933),
    "b": Coordinate(lat:45.49735, long:-73.57918),
    "c": Coordinate(lat:45.49755, long:-73.57899),
    "y": Coordinate(lat:45.49741, long:-73.57868),
    "d": Coordinate(lat:45.49734,long: -73.57855),
    "e": Coordinate(lat:45.49714,long: -73.57875),
    "x": Coordinate(lat:45.4972, long:-73.57887),
    "f": Coordinate(lat:45.49698, long:-73.57888)

  };

 void addLane(String laneId, int sourceLocNo, int destLocNo,
            int duration) {
        Coordinate source = nodes[sourceLocNo].point;
        Coordinate dest = nodes[destLocNo].point;

        List<Coordinate> ptsinBetween = getPoints(source, dest);
        var prevNode = nodes[sourceLocNo]; 
        for(int i=0; i<ptsinBetween.length ; i++){
          
          if(i==ptsinBetween.length -1){
          // nodes.add(new Vertex(nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), nodes[sourceLocNo].getName()+"_"+nodes[destLocNo].getName(), ptsinBetween[i]));
          edges.add(new Edge( source: prevNode, destination: nodes[destLocNo], weight: 1 ));
          edges.add(new Edge(source: nodes[destLocNo], destination: prevNode, weight:1 ));
          break;
          }
          nodes.add(new Vertex(name: nodes[sourceLocNo].name+"_"+nodes[destLocNo].name, point: ptsinBetween[i]));
          edges.add(new Edge(source: prevNode, destination: nodes[nodes.length-1], weight: 1 ));
          edges.add(new Edge(source: nodes[nodes.length-1], destination: prevNode, weight: 1 ));
          prevNode = nodes[nodes.length-1];

        } 

                


              
    }

    getJunctionAsVertex(String junction, Map<String, Coordinate>  pts){
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

  List<Coordinate> getPath(Coordinate ast, Coordinate bend) {
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
          nodes.add(new Vertex(name:k.toString(), point: v))));

   
        

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
        convertKDRetToOnePoint(tree.nearest({'x': start.lat, 'y': start.long}, 1));
    var closestEndJunction =
        convertKDRetToOnePoint(tree.nearest({'x': end.lat, 'y': end.long}, 1));
      

        // Lets check from location Loc_1 to Loc_10
        Graph graph = new Graph(vertexes: nodes, edges: edges);
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

        List<Coordinate> ret = [];
        for(var item in lst){
          ret.add(item.point);
        }

        // ret[0] = start;
        // ret[ret.length-1] = end;
        return ret;
        
  }

  List<Map<String, double>> convertMapToKDFormat(Map<String, Coordinate> map) {
    List<Map<String, double>> ret = [];
    map.forEach((k, v) => (ret.add({'x': v.lat, 'y': v.long})));

    return ret;
  }

  List<Map<String, double>> convertListToKDFormat(List<Vertex> lst){
    List<Map<String, double>> ret = [];
    lst.forEach((element) => (ret.add({'x': element.point.lat, 'y': element.point.long})));

    return ret;
  }

  Coordinate convertKDRetToOnePoint(List<dynamic> kdRet) {
    var point = kdRet[0][0];
    var ret = new Coordinate(lat: point['x'], long: point['y']);
    return ret;
  }

  //get all points in straight line in between a and b  in normal format
  List<Coordinate> getPoints(Coordinate a, Coordinate b) {
    List<Coordinate> ret = [];
    List<double> equation = lineFromPoints(a, b);

    double interval = ((b.lat - a.lat) / 20);

    double begin = a.lat;
    for (int i = 0; i <= 20; i++) {
      var lat = begin;
      var long = equation[0] * lat + equation[1];
      ret.add(Coordinate(lat: lat, long: long));
      begin += interval;
    }

    return ret;
  }

  //get all points in straight line in between a and b  in kdtree format
  List<Map<String, double>> getPointsKD(Coordinate a, Coordinate b) {
    List<Coordinate> ret = [];
    List<Map<String, double>> ret2 = [];
    List<double> equation = lineFromPoints(a, b);

    double interval = ((b.lat - a.lat) / 6);

    double begin = a.lat;
    for (int i = 0; i <= 6; i++) {
      var lat = begin;
      var long = equation[0] * lat + equation[1];
      ret.add(Coordinate(lat: lat, long: long));
      ret2.add({'x': lat, 'y': long});
      begin += interval;
    }

    return ret2;
  }

//y = mx + b from two points and returns list containing m and b
  List<double> lineFromPoints(Coordinate p1, Coordinate p2) {
    List<double> equation = [];
    double deltaY = p2.long - p1.long;
    double deltaX = p2.lat - p1.lat;
    double m = deltaY / deltaX;
    double b = p1.long - (m * p1.lat);

    equation.add(m);
    equation.add(b);
    return equation;
  }

  List<Coordinate> pointsFromListMap(List<dynamic> list) {
    List<Coordinate> ret = [];

    for (int i = 0; i < list.length; i++) {
      ret.add(Coordinate(lat: list[i][0]['x'], long: list[i][0]['y']));
    }

    return ret;
  }
}
