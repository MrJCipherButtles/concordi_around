import 'package:concordi_around/services/map_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/services/constants.dart' as constants;

void main() {

 group("Campus tests", () {
   test('Should be within SGW campus', (){
   expect(MapHelper.isWithinSGW(LatLng(45.495675, -73.578296)), true);
   expect(MapHelper.isWithinSGW(LatLng(45.503080, -73.580781)), false);
   expect(MapHelper.isWithinSGW(null), false);
  });

  test('Should be in Hall Building', (){
   expect(MapHelper.isWithinHall(LatLng(45.497222, -73.578791)), true);
   expect(MapHelper.isWithinHall(LatLng(45.496865, -73.578056)), false);
   expect(MapHelper.isWithinHall(null), false);
  });

  test('Should be within the bounds of Hall Building on the map', (){
   expect(MapHelper.isWithinHallStrictBound(LatLng(45.49726709926478, -73.57894677668811)), true);
   expect(MapHelper.isWithinHallStrictBound(LatLng(45.494901, -73.579351)), false);
   expect(MapHelper.isWithinHallStrictBound(null), false);
  });

  test('Should be within Loyola campus', (){
   expect(MapHelper.isWithinLoyola(LatLng(45.458065, -73.640538)), true);
   expect(MapHelper.isWithinLoyola(LatLng(45.463359, -73.636186)), false);
  expect(MapHelper.isWithinLoyola(null), false);
  });
 });
}