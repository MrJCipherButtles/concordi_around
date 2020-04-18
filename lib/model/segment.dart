import 'dart:math';
import 'coordinate.dart';

class Segment {
  /*
  -------ATTRIBUTES-------
  //Although a trivial segment, source and destination can be equal
  */
  final Coordinate _source;
  final Coordinate _destination;

  /*
  -------CONSTRUCTOR-------
   */

  Segment(this._source, this._destination);

  /*
  -------GETTERS-------
   */

  Coordinate get source => _source;
  Coordinate get destination => _destination;

  /*
  -------PUBLIC METHODS-------
   */

  //A segment is only false when source and destination are both not disability friendly
  //e.g. top floor to bottom floor returns false, but stairs to classroom on the same floor returns true
  bool isDisabilityFriendly() {
    //There is only a concern for disability when traversing different floors
    if (_source is PortalCoordinate &&
        _destination is PortalCoordinate &&
        _source.floor != _destination.floor) {
      return (_source as PortalCoordinate).isDisabilityFriendly &&
          (_destination as PortalCoordinate).isDisabilityFriendly;
    }
    //else one coordinate must not be a portal; therefore, true by default
    return true;
  }

  //Distance between the _source to _destination in meters
  double length() {
    var phi1 = _rad(_source.lat);
    var phi2 = _rad(_destination.lat);
    var lam1 = _rad(_source.lng);
    var lam2 = _rad(_destination.lng);
    return 6371010 *
        acos(sin(phi1) * sin(phi2) + cos(phi1) * cos(phi2) * cos(lam2 - lam1));
  }

  @override
  String toString() => '${_source.toString()} -> ${_destination.toString()}';

  /*
  -------PRIVATE METHOD-------
   */

  //Radian to degree converter
  static double _rad(double deg) => deg * pi / 180;
}
