import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/provider/map_notifier.dart';

void main() {
  group("Map Notifier Unit tests", () {
    test('Map Notifier Unit test verifying the floor and building methods work',
        () {
      var mp = MapNotifier();

      expect(mp.showFloorPlan, false);
      expect(mp.selectedFloorPlan, 9);
      expect(mp.showEnterBuilding, false);
      expect(mp.currentCampus, 'SGW');
    });

    test('Setter methods should work as expected', () {
      var mp = MapNotifier();

      mp.setFloorPlanVisibility(true);
      mp.setSelectedFloor(8);
      mp.setEnterBuildingVisibility(true);
      mp.setCampusLatLng(LatLng(45.458279, -73.640436));
      mp.setPopupInfoVisibility(true);
      mp.setPlaceLatLng(LatLng(45.458279, -73.640436));

      expect(mp.showFloorPlan, true);
      expect(mp.selectedFloorPlan, 8);
      expect(mp.showEnterBuilding, true);
      expect(mp.currentCampus, 'LOY');
      expect(mp.showInfo, true);
      expect(mp.selectedLatlng, LatLng(45.458279, -73.640436));

      mp.setCampusLatLng(LatLng(45.49558, -73.57801));
      expect(mp.currentCampus, 'SGW');

      mp.setCampusString("SGW");
      expect(mp.currentCampus, 'SGW');
    });

    test('Future methods should bring us to correct locations', () async {
      var mp = MapNotifier();

      mp.goToSpecifiedLatLng(
          coordinate: Coordinate(45.458279, -73.640436, '', '', ''));
    });
  });
}
