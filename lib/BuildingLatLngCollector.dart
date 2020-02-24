import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';

import 'Building.dart';
import 'KmlParser.dart';

class BuildingLatLngCollector {

  List<Building> getLatLngConfigString(String kmlString) {
    KmlParser kmlParser = new KmlParser();
    Map<String, dynamic> json = kmlParser.getJsonFromKMLString(kmlString);
    List<Building> buildings = new List();

    for(Map<String, dynamic> placemarker in json["kml"]["Document"]["Placemark"]) {
      List<LatLng> latlng = new List();
      String id = placemarker["name"];

      var string = placemarker["Polygon"]["outerBoundaryIs"]["LinearRing"]["coordinates"];
      var coordinates = string.split("\\n");

      for(var coordinate in coordinates) {
        coordinate = coordinate.trim();
        if(!coordinate.isEmpty) {
          var lnglat = coordinate.split(",");
          LatLng point = LatLng(double.parse(lnglat[1]), double.parse(lnglat[0]));
          latlng.add(point);
        }
      }
      Building building = new Building(id, latlng);
      buildings.add(building);
    }
    return buildings;
  }
}