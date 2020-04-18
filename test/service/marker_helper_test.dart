import 'package:concordi_around/service/marker_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/data/data_points.dart';

void main() {
  MarkerHelper marker;

  group("Marker tests:", () {
    test('Marker Initialize', () async {
      marker = await MarkerHelper();
      expect(marker.eightfloorMarker.length, 0);
      //wait for the data to set properly
      await Future.delayed(const Duration(seconds: 2), () {});

      expect(marker.eightfloorMarker.length, 61);
      expect(marker.ninthfloorMarker.length, 38);
    });

    test('Marker Helper method tests', () async {
      marker = await MarkerHelper();
      expect(marker.eightfloorMarker.length, 0);
      //wait for the data to set properly
      await Future.delayed(const Duration(seconds: 2), () {});

      expect(marker.eightfloorMarker.length, 61);
      expect(marker.ninthfloorMarker.length, 38);

      int tempSetLength = marker.getFloorMarkers(8).length;
      expect(tempSetLength, marker.eightfloorMarker.length);
      tempSetLength = marker.getFloorMarkers(9).length;
      expect(tempSetLength, marker.ninthfloorMarker.length);

      //setStartEndMarker for 8 floor
      tempSetLength = marker.getFloorMarkers(8).length;
      marker.setStartEndMarker(
          RoomCoordinate(0.0, 0.0, '8', ' ', ' ', roomId: 'No'),
          RoomCoordinate(0.0, 0.0, '8', ' ', ' ', roomId: 'Yes'));
      expect(tempSetLength < marker.eightfloorMarker.length , true );

      //setStartEndMarker for 9 floor
      tempSetLength = marker.getFloorMarkers(9).length;
      marker.setStartEndMarker(
          RoomCoordinate(0.0, 0.0, '9', ' ', ' ', roomId: 'No'),
          RoomCoordinate(0.0, 0.0, '9', ' ', ' ', roomId: 'Yes'));
      expect(tempSetLength < marker.ninthfloorMarker.length , true );
      
      //removeStartEndMarker
      tempSetLength = marker.getFloorMarkers(9).length;
      marker.removeStartEndMarker();
      expect(tempSetLength > marker.ninthfloorMarker.length , true );

      //getBuildingMarkers
      tempSetLength = 0;
      Set<Marker> tempSet = marker.getBuildingMarkers();
      expect(tempSet.length > tempSetLength, true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_EV'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_JMSB'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_GM'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_LB'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_H'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_VL'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_FC'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_PB'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_CJ'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_SP'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_CB'), true);
      expect(tempSet.any((mark) => mark.markerId.value == 'buildingMarker_PSB'), true);

    });
  });
}
