import 'dart:collection';

import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
part 'coordinate.jorm.dart';

class Coordinate {
  int id;

  @PrimaryKey()
   double _lat;

  @PrimaryKey()
   double _lng;
   String _floor;
   String _building;
   String _campus;
  String _type;


  
  @HasMany(CoordinateBean)
  List<Coordinate> _adjCoordinates;

  @BelongsTo.many(CoordinateBean)
  int parentId;



  Coordinate({this.id, this.parentId, lat, lng, floor, building, campus, type, adjCoordinates}) {
    _type = type;
    _adjCoordinates = adjCoordinates;
    _lat = lat;
    _lng=lng;
    _floor = floor;
    _building = building;
    _campus= campus;

    
  }

  double get lat => _lat;
  double get lng => _lng;
  String get floor => _floor;
  String get building => _building;
  String get campus => _campus;
  String get type => _type;
  List<Coordinate> get adjCoordinates => _adjCoordinates;

  set type(String type) => _type = type;
//   set adjCoordinates(List<Coordinate> adjCoordinates) => _adjCoordinates = adjCoordinates;


  
  String toString() => this.id.toString();
}

class PortalCoordinate extends Coordinate {

  
}

class RoomCoordinate extends Coordinate {
 
}



@GenBean()
class CoordinateBean extends Bean<Coordinate> with _CoordinateBean {
  CoordinateBean _coordinateBean;


  CoordinateBean(Adapter adapter) : super(adapter);

  String get tableName => 'coordinate';

  @override
  // TODO: implement coordinateBean
  CoordinateBean get coordinateBean {
    _coordinateBean ??= new CoordinateBean(adapter);
    return _coordinateBean;
  }
}