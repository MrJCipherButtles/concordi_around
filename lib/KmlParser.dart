import 'dart:convert';
import 'package:xml2json/xml2json.dart';


//main() {
//  BuildingLatLngCollector buildingLatLngCollector = new BuildingLatLngCollector();
//  List<Building> buildings = buildingLatLngCollector.getLatLngConfigString(BuildingLayer.xml);
//  for(Building building in buildings) {
//    print(building.boundary.toString());
//  }
//}

class KmlParser {
  getJsonFromKMLString(String kmlString) {
    final Xml2Json xml2Json = Xml2Json();

    try {
      xml2Json.parse(kmlString);

      var jsonString = xml2Json.toParker();
      return jsonDecode(jsonString);
    } catch (e) {
      print(e);
    }
  }
}

