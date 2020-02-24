import 'Coordinate.dart';

class Segment {

  final Coordinate _source;
  final Coordinate _destination;

  Segment(this._source, this._destination){
    assert (_source != _destination);
  }

  Coordinate get source => _source;
  Coordinate get destination => _destination;

  @override
  String toString() => _source.toString() + '->' + _destination.toString();
}
