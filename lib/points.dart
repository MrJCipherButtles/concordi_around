import 'dart:math';

// import 'package:latlong/latlong.dart';
import 'package:graphs/graphs.dart';
import 'package:kdtree/kdtree.dart';
import 'package:collection/collection.dart';





import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() {


// List<Map<String, double>> pointsAB = new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918));
// List<Map<String, double>> pointsBC = new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899));
// List<Map<String, double>> pointsCY = new Coords().getPoints(LatLng(45.49755, -73.57899), LatLng(45.49741, -73.57868));
// List<Map<String, double>> pointsYX = new Coords().getPoints(LatLng(45.49741, -73.57868), LatLng(45.4972, -73.57887));



// var points = pointsAB + pointsBC+ pointsCY + pointsYX;

// var distance = (a, b) {
//   return pow(a['x'] - b['x'], 2) + pow(a['y'] - b['y'], 2);
// };

// var tree = KDTree(points, distance, ['x', 'y']);

// var nearest = tree.nearest({'x': 45.49739,  'y':  -73.57914}, 10);
// var nearest2 = tree.nearest({'x': 45.49727,  'y':  -73.57926}, 10);


// // print(nearest);
// // print(nearest2);



// Function eq = const MapEquality().equals;

// var same = [];
// for(int i = 0; i< nearest.length; i++){
//   for(int j=0; j<nearest2.length; j++){
//     if(eq(nearest[i][0],nearest2[j][0])){
//       same.add(nearest[i]);
//     }
//   }
// }

// print(same);


// ///get all points in straight line in between a and b
//   List<LatLng> pointsFromListMap(List<dynamic> list) {
//     List<LatLng> ret = [];
    
//     for (int i = 0; i <list.length; i++) {
//       ret.add(LatLng(list[i][0]['x'], list[i][0]['y']));
//     }

//     return ret;
//   }

 




//     List<LatLng> _products = pointsFromListMap(same);

//   for (int i = 0; i < _products.length; i++) {
//     print(_products[i].latitude.toString() +" "+ _products[i].longitude.toString());
//   }

//   // var lol = new Coordis().lineFromPoints(LatLng(45.49755, -73.57899), LatLng(45.49734, -73.57855));
//   // print(lol[1].toString());
// }

class Coords {


// List<Map<String, double>> pointsAB = new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918));
// List<Map<String, double>> pointsBC = new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899));
// List<Map<String, double>> pointsCY = new Coords().getPoints(LatLng(45.49755, -73.57899), LatLng(45.49741, -73.57868));
// List<Map<String, double>> pointsYX = new Coords().getPoints(LatLng(45.49741, -73.57868), LatLng(45.4972, -73.57887));


  List<LatLng> ac = [];


List<LatLng> getPath(){
  var points = new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918)) + new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899))+new Coords().getPoints(LatLng(45.49755, -73.57899), LatLng(45.49741, -73.57868))+new Coords().getPoints(LatLng(45.49741, -73.57868), LatLng(45.4972, -73.57887))
  + new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.4972, -73.57887));

points = points.toSet().toList();
var distance = (a, b) {
  return pow(a['x'] - b['x'], 2) + pow(a['y'] - b['y'], 2);
};

var tree = KDTree(points, distance, ['x', 'y']);

var nearest = tree.nearest({'x': 45.49739,  'y':  -73.57914}, 2);
var nearest2 = tree.nearest({'x': 45.4973,  'y':  -73.57877}, 2);




// print(nearest);
// print(nearest2);



Function eq = const MapEquality().equals;

var same = nearest+nearest2;



for(int i = 0; i< nearest.length; i++){
  for(int j=0; j<nearest2.length; j++){
    if(eq(nearest[i][0],nearest2[j][0])){
      same.add(nearest[i]);
    }
  }
}

// print(same);

return pointsFromListMap(same);
}

//get all points in straight line in between a and b
  List<Map<String, double>> getPoints(LatLng a, LatLng b) {
    List<LatLng> ret = [];
    List<Map<String, double>> ret2 = [];
    List<double> equation = lineFromPoints(a, b);

    double interval = ((b.latitude - a.latitude) / 4);

    double begin = a.latitude;
    for (int i = 0; i <= 4; i++) {
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
    
    for (int i = 0; i <list.length; i++) {
      ret.add(LatLng(list[i][0]['x'], list[i][0]['y']));
    }

    

    return ret;
  }

}
