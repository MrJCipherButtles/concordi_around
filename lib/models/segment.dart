import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'coordinate.dart';

class Segment {

  final Coordinate _source;
  final Coordinate _destination;

  //Although trivial, a segment from one point to the same should be possible
  Segment(this._source, this._destination);

  Coordinate get source => _source;
  Coordinate get destination => _destination;

  bool isDisabilityFriendly(){
    //A segment is only false when source and destination are both not disability friendly
    //e.g. top floor to bottom floor returns false, but stairs to classroom on the same floor returns true
    //There is only a concern for disability when traversing different floors
    if (_source is PortalCoordinate && _destination is PortalCoordinate && _source.floor != _destination.floor) {
      return ((_source as PortalCoordinate).isDisabilityFriendly && (_destination as PortalCoordinate).isDisabilityFriendly);
    }
    //else one coordinate must not be a portal; therefore, true by default
    return true;
  }

  //Distance between the _source to _destination in meters
  double length(){
    var phi1 = _rad(_source.lat);
    var phi2 = _rad(_destination.lat);
    var lam1 = _rad(_source.lng);
    var lam2 = _rad(_destination.lng);
    return 6371010 * acos( sin(phi1) * sin(phi2) + cos(phi1) * cos(phi2) * cos(lam2 - lam1));
  }

  static double _rad(double deg) => deg * pi/180;

//  Polyline toPolyline() {
//    return Polyline(
//      polylineId: PolylineId(_source.toString()),
//      points: [_source.toLatLng(), _destination.toLatLng()],
//      visible: true,
//      jointType: JointType.bevel,
//      patterns: [PatternItem.dot],
//      color: Color.fromRGBO(147, 0, 47, 1)
//    );
//  }

  @override
  String toString() => _source.toString() + '->' + _destination.toString();
}
