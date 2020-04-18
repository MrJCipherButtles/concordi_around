import 'dart:ui';
import 'coordinate.dart';
import 'segment.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Path {
  /*
  -------ATTRIBUTES-------
  */

  final List<Segment> _segments = <Segment>[];

  /*
  -------CONSTRUCTOR-------
   */

  Path(List<Coordinate> coordinateList) {
    assert(coordinateList != null && coordinateList.length > 1);
    for (var i = 0; i < coordinateList.length - 1; i++) {
      _segments.add(Segment(coordinateList[i], coordinateList[i + 1]));
    }
  }

  /*
  -------GETTER-------
   */

  List<Segment> get segments => _segments;

  /*
  -------PUBLIC METHODS-------
   */

  //Converts path to list of coordinates (order is important)
  List<Coordinate> coordinatesInOrder() {
    var orderedCoordinateList = <Coordinate>[];
    //add the source coordinate of the first segment
    orderedCoordinateList.add(_segments[0].source);
    for (var segment in _segments) {
      //then add all destination coordinates for each segment (avoids duplicates)
      orderedCoordinateList.add(segment.destination);
    }
    return orderedCoordinateList;
  }

  //A path is disability-friendly if all its segments are disability-friendly
  bool isDisabilityFriendly() {
    for (var segment in _segments) {
      if (!segment.isDisabilityFriendly()) {
        return false;
      }
    }
    return true;
  }

  //The length of a path is the sum of all segments
  double length() {
    var length = 0.0;
    for (var segment in _segments) {
      length += segment.length();
    }
    return length;
  }

  //Converts path to polyline for Google Maps compatibility
  Polyline toPolyline() {
    var coordinates = coordinatesInOrder();
    var points = <LatLng>[];
    for (var coordinate in coordinates ?? []) {
      points.add(coordinate.toLatLng());
    }
    return Polyline(
        polylineId: PolylineId(coordinates.toString()),
        points: points,
        visible: true,
        width: 5,
        jointType: JointType.bevel,
        patterns: [PatternItem.dot],
        color: Color.fromRGBO(147, 0, 47, 1));
  }

  //prints path in order
  @override
  String toString() {
    var buffer = StringBuffer();
    for (var coordinate in coordinatesInOrder()) {
      buffer.write(coordinate.toString());
    }
    return buffer.toString();
  }
}
