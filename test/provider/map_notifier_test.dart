import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/provider/map_notifier.dart';

void main() {
  test('Map Notifier Unit test verifying the floor and building methods work',
      () {
    var mp = MapNotifier();

    expect(mp.showFloorPlan, false);
    expect(mp.selectedFloorPlan, 9);
    expect(mp.showEnterBuilding, false);
    expect(mp.currentCampus, 'SGW');

    mp.setFloorPlanVisibility(true);
    mp.setSelectedFloor(8);
    mp.setEnterBuildingVisibility(true);
    mp.setCampusLatLng(LatLng(45.458279, -73.640436));

    expect(mp.showFloorPlan, true);
    expect(mp.selectedFloorPlan, 8);
    expect(mp.showEnterBuilding, true);
    expect(mp.currentCampus, 'LOY');
  });
}
