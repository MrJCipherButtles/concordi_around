import 'package:concordi_around/data/building_singleton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonHelper {
  Set<Polygon> eightFloorPolygon;
  Set<Polygon> ninthFloorPolygon;

  PolygonHelper() {
    eightFloorPolygon = BuildingSingleton().getFloorPolygon('hall', '8');
    ninthFloorPolygon = BuildingSingleton().getFloorPolygon('hall', '9');
  }

  Set<Polygon> getFloorPolygon(int selectedFloor) {
    return selectedFloor == 8 ? eightFloorPolygon : ninthFloorPolygon;
  }
}
