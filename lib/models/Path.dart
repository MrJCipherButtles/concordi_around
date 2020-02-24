
import 'Coordinate.dart';
import 'Segment.dart';

class Path {
  final List<Segment> _segments = <Segment>[];

  Path(List<Coordinate> coordinateList) {
    assert (coordinateList != null && coordinateList.length > 1);
    for(var i = 0; i < coordinateList.length - 1; i++) {
      _segments.add(Segment(coordinateList[i], coordinateList[i+1]));
    }
  }

  Set<Coordinate> getCoordinatesInOrder() {
    var ls = <Coordinate>{};
    ls.add(_segments[0].source);
    for(var segment in _segments) {
      ls.add(segment.destination);
    }
    return ls;
  }

  bool isDisabilityFriendly(){
    for(var segment in _segments) {
      if(!segment.isDisabilityFriendly()) {
        return false;
      }
    }
    return true;
  }

  @override
  String toString(){
    var buffer = StringBuffer();
    for(var coordinate in getCoordinatesInOrder()) {
      buffer.write(coordinate.toString());
    }
    return buffer.toString();
  }
}
