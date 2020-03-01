import 'coordinate.dart';
import 'segment.dart';

class Path {
  final List<Segment> _segments = <Segment>[];

  Path(List<Coordinate> coordinateList) {
    assert(coordinateList != null && coordinateList.length > 1);
    for (var i = 0; i < coordinateList.length - 1; i++) {
      _segments.add(Segment(coordinateList[i], coordinateList[i + 1]));
    }
  }

  List<Segment> get segments => _segments;

  List<Coordinate> coordinatesInOrder() {
    var ls = <Coordinate>[];
    //add the source coordinate of the first segment
    ls.add(_segments[0].source);
    for (var segment in _segments) {
      //then add all destination coordinates for each segment
      //(avoids duplicate coordinates although set data structure enforces this)
      //So should we keep Set or change to List? TBD
      ls.add(segment.destination);
    }
    return ls;
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

  @override
  String toString() {
    var buffer = StringBuffer();
    for (var coordinate in coordinatesInOrder()) {
      buffer.write(coordinate.toString());
    }
    return buffer.toString();
  }
}
