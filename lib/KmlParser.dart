
import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart' as xml;

main() async {
  String filePath = "/Users/umer/workspace/concordi_around/assets/layers/Building_layer.kml";
  KmlParser kmlParser = new KmlParser();
  String fileData = await kmlParser.getFileData(filePath);
  xml.XmlDocument doc = kmlParser.parseFile(fileData);
  print(doc.toString());
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

  Future<String> getFileData(String path) async {
    String contents;
    var file = File(path);

    if (await file.exists()) {
    // Read file
    contents = await file.readAsString();
    }
    return contents;
  }

  xml.XmlDocument parseFile(String content) {
    return xml.parse(content);
  }

}