import 'Coordinate.dart';
import 'PortalCoordinate.dart';

class Segment {

  final Coordinate _source;
  final Coordinate _destination;

  Segment(this._source, this._destination){
    assert (_source != _destination);
  }

  Coordinate get source => _source;
  Coordinate get destination => _destination;

  bool isDisabilityFriendly(){
    //A segment is only false when source and destination are both not disability friendly
    //e.g. top floor to bottom floor returns false, but stairs to classroom on the same floor returns true
    if (_source is PortalCoordinate && _destination is PortalCoordinate) {
      return (_source as PortalCoordinate).isDisabilityFriendly || (_destination as PortalCoordinate).isDisabilityFriendly;
    }
    //else one coordinate must not be a portal; therefore, true by default
    return true;
  }

  @override
  String toString() => _source.toString() + '->' + _destination.toString();
}
