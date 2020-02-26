import 'dart:collection';

import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
part 'coordinate.jorm.dart';

class Coordinate {
  int id;

  @PrimaryKey()
   double lat;

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



  Coordinate({this.id, parentId, this.lat, lng, floor, building, campus, type, adjCoordinates}) {
    _type = type;
    _adjCoordinates = adjCoordinates;
  }
  
  
  


  
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