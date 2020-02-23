
import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

main() async {
  String filePath = "/Users/umer/workspace/concordi_around/assets/layers/Building_layer.kml";
  KmlParser kmlParser = new KmlParser();

  Map<String, dynamic> json = await kmlParser.getJsonFromXMLFile(filePath);

  for(Map<String, dynamic> placemarker in json["kml"]["Document"]["Placemark"]) {
    String id = placemarker["name"];
    print(id);
    var string = placemarker["Polygon"]["outerBoundaryIs"]["LinearRing"]["coordinates"];
    var coordinates = string.split("\\n");
  }

}

class KmlParser {
  // Set<Polygon> polygons;
  // static List<LatLng> polyPoints;
  // String path = "assets/layers/Building_layer.kml";

  // Polygon poly = Polygon(
  //           polygonId: PolygonId("1"),
  //           visible: true,
  //           //latlng is List<LatLng>
  //           points: polyPoints,
  //           fillColor: Colors.yellow,
  //           strokeColor: Colors.yellow
  //       );

  getJsonFromXMLFile(path) async {
    final Xml2Json xml2Json = Xml2Json();

    try {
      var content = await File(path).readAsString();
      xml2Json.parse(content);

      var jsonString = xml2Json.toParker();
      return jsonDecode(jsonString);
    } catch (e) {
      print(e);
    }
  }
}