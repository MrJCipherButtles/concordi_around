
import 'Path.dart';

class Floor {
  final String _floorLevel;
  //final Set<Coordinate> _polygon = <Coordinate>{};
  Path _path;
  Floor(this._floorLevel);

  Path get path => _path;
  String get floorLevel => _floorLevel;
}
