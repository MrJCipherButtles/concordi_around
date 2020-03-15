import 'dart:math';

import 'package:concordi_around/service/map_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/building.dart';
import '../model/coordinate.dart';
import '../model/floor.dart';
import 'data_points.dart';
import 'building_list.dart' as building_list_data;

class BuildingSingleton {
  static final BuildingSingleton _instance = BuildingSingleton._internal();

  Map<String, Building> _buildings;

  factory BuildingSingleton() {
    return _instance;
  }

  BuildingSingleton._internal() {
    _buildings = building_list_data.buildings;
    _initHallEightFloor(_buildings['H']);
    _initHallNinthFloor(_buildings['H']);
  }

  Map<String, Building> get buildings => _buildings;

  List<Building> getBuildingList() {
    var result = <Building>[];
    _buildings.forEach((k, v) => result.add(v));
    return result;
  }

  List<RoomCoordinate> getAllRooms() {
    List<RoomCoordinate> roomList = <RoomCoordinate>[];
    for (Building building in this.buildings.values) {
      building.floors.forEach((floorName, floor) => floor
          .coordinatesByGivenTypes({"ROOM"}).forEach(
              (room) => roomList.add(room)));
    }
    return roomList;
  }

  Set<Polygon> getOutdoorBuildingHighlights() {
    Set<Polygon> result = {};
    for (var building in buildings.values) {
      List<LatLng> latlngs = new List();

      if (building.polygon == null) {
        continue;
      }

      for (var coordinate in building.polygon) {
        latlngs.add(coordinate.toLatLng());
      }

      result.add(Polygon(
          polygonId: PolygonId(building.building),
          fillColor: COLOR_CONCORDIA.withOpacity(0.4),
          strokeWidth: 3,
          points: latlngs,
          zIndex: 1));
    }
    return result;
  }

  Set<Polygon> getFloorPolygon(String buildingName, String floorName) {
    Set<Polygon> result = {};
    for (var building in _buildings.values) {
      if (building.building
          .toUpperCase()
          .contains(buildingName.toUpperCase())) {
        if (building.floors != null) {
          var floor = building.floors[floorName];
          if (floor != null && floor.polygons != null) {
            for (List<Coordinate> list in floor.polygons) {
              List<LatLng> points = new List();
              list.forEach((coordinate) => points.add(coordinate.toLatLng()));
              Random rnd = Random();
              result.add(Polygon(
                  polygonId:
                      PolygonId('${floor.floor}-${rnd.nextInt(100000000)}'),
                  points: points,
                  fillColor: COLOR_CONCORDIA.withOpacity(0.4),
                  strokeWidth: 3,
                  zIndex: 2));
            }
          }
        }
      }
    }
    return result;
  }

  Set<Marker> getFloorMarker(String buildingName, String floorName) {
    Set<Marker> result = {};
    for (var building in _buildings.values) {
      if (building.building
          .toUpperCase()
          .contains(buildingName.toUpperCase())) {
        if (building.floors != null) {
          var floor = building.floors[floorName];
          List<RoomCoordinate> markers = floor.coordinatesByGivenTypes({'MARKER'});
          markers.forEach((f) => result.add(Marker(
              markerId: MarkerId(f.roomId),
              infoWindow: InfoWindow(title: f.roomId))));
        }
      }
    }
    return result;
  }

  void _initHallEightFloor(Building hall) {
    PortalCoordinate j8F1 = PortalCoordinate(
        45.4971951, -73.579341, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F2 = PortalCoordinate(
        45.497265, -73.5792743, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F3 = PortalCoordinate(
        45.4973532, -73.5791857, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F4 = PortalCoordinate(
        45.4974917, -73.5790559, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F5 = PortalCoordinate(
        45.4975589, -73.5789924, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F6 = PortalCoordinate(
        45.4973987, -73.579035, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F7 = PortalCoordinate(
        45.4974122, -73.578687, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F8 = PortalCoordinate(
        45.4973444, -73.578548, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F9 = PortalCoordinate(
        45.4973621, -73.578735, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F10 = PortalCoordinate(
        45.4972072, -73.5788831, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F11 = PortalCoordinate(
        45.4971366, -73.5787401, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F12 = PortalCoordinate(
        45.4973283, -73.5787675, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F13 = PortalCoordinate(
        45.497251, -73.5789738, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F14 = PortalCoordinate(
        45.4970442, -73.5788285, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F15 = PortalCoordinate(
        45.4969788, -73.5788903, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F16 = PortalCoordinate(
        45.4972827, -73.5789415, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F17 = PortalCoordinate(
        45.4974342, -73.5791097, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    j8F1.adjCoordinates = {j8F2, j8F15};
    j8F2.adjCoordinates = {j8F1, j8F3};
    j8F3.adjCoordinates = {j8F2, j8F17};
    j8F4.adjCoordinates = {j8F5, j8F17};
    j8F5.adjCoordinates = {j8F4, j8F7};
    j8F6.adjCoordinates = {j8F17};
    j8F7.adjCoordinates = {j8F5, j8F8, j8F9};
    j8F8.adjCoordinates = {j8F7, j8F11};
    j8F9.adjCoordinates = {j8F7, j8F12};
    j8F10.adjCoordinates = {j8F11, j8F12, j8F13};
    j8F11.adjCoordinates = {j8F8, j8F10, j8F14};
    j8F12.adjCoordinates = {j8F9, j8F10};
    j8F13.adjCoordinates = {j8F3, j8F10, j8F16};
    j8F14.adjCoordinates = {j8F11, j8F15};
    j8F15.adjCoordinates = {j8F14, j8F1};
    j8F16.adjCoordinates = {j8F13};
    j8F17.adjCoordinates = {j8F3, j8F4, j8F6};

    RoomCoordinate h801 = RoomCoordinate(45.4973307, -73.5785616, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H801", adjCoordinates: {j8F8, j8F11});

    RoomCoordinate h803 = RoomCoordinate(45.4972776, -73.5786106, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H803", adjCoordinates: {j8F8, j8F11});

    RoomCoordinate h805 = RoomCoordinate(45.4972277, -73.5786569, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H805", adjCoordinates: {j8F8, j8F11});

    RoomCoordinate h806 = RoomCoordinate(45.4971761, -73.5788206, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H806", adjCoordinates: {j8F10, j8F11});

    RoomCoordinate h807 = RoomCoordinate(45.4971802, -73.5787002, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H807", adjCoordinates: {j8F8, j8F11});

    RoomCoordinate h811 = RoomCoordinate(45.4970862, -73.5787884, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H811", adjCoordinates: {j8F11, j8F14});

    RoomCoordinate h813 = RoomCoordinate(45.4970359, -73.5788358, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H813", adjCoordinates: {j8F14, j8F15});

    RoomCoordinate h815 = RoomCoordinate(45.4969912, -73.5788789, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H815", adjCoordinates: {j8F14, j8F15});

    RoomCoordinate h817 = RoomCoordinate(45.4969788, -73.5788902, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H817", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h819 = RoomCoordinate(45.4969858, -73.5789055, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H819", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h820 = RoomCoordinate(45.497047, -73.5790332, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H820", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h821 = RoomCoordinate(45.4970194, -73.5789754, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H821", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h822 = RoomCoordinate(45.4971302, -73.5792069, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H822", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h823 = RoomCoordinate(45.4970505, -73.5790399, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H823", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h825 = RoomCoordinate(45.4970839, -73.5791094, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H825", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h827 = RoomCoordinate(45.4971167, -73.5791776, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H827", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h829 = RoomCoordinate(45.4971699, -73.5792892, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H829", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h831 = RoomCoordinate(45.4971889, -73.5793479, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H831", adjCoordinates: {j8F1});

    RoomCoordinate h835 = RoomCoordinate(45.4972492, -73.5792886, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H835", adjCoordinates: {j8F1, j8F2});

    RoomCoordinate h833 = RoomCoordinate(45.4972025, -73.579334, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H833", adjCoordinates: {j8F1, j8F2});

    RoomCoordinate h837 = RoomCoordinate(45.4973005, -73.5792377, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H837", adjCoordinates: {j8F3, j8F2});

    RoomCoordinate h838 = RoomCoordinate(45.4973915, -73.5791498, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H838", adjCoordinates: {j8F3, j8F17});

    RoomCoordinate h841 = RoomCoordinate(45.4974017, -73.5791402, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H841", adjCoordinates: {j8F3, j8F17});

    RoomCoordinate h843 = RoomCoordinate(45.4974606, -73.5790849, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H843", adjCoordinates: {j8F4, j8F17});

    RoomCoordinate h845 = RoomCoordinate(45.4975062, -73.5790422, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H845", adjCoordinates: {j8F4, j8F5});

    RoomCoordinate h847 = RoomCoordinate(45.4975497, -73.5790013, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H847", adjCoordinates: {j8F4, j8F5});

    RoomCoordinate h849 = RoomCoordinate(45.4975645, -73.5789853, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H849", adjCoordinates: {j8F5});

    RoomCoordinate h851 = RoomCoordinate(45.4975695, -73.5789792, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H851", adjCoordinates: {j8F5});

    RoomCoordinate h852 = RoomCoordinate(45.497505, -73.5788792, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H852", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h853 = RoomCoordinate(45.4975315, -73.5789348, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H853", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h854 = RoomCoordinate(45.4974968, -73.5788628, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H854", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h855 = RoomCoordinate(45.4974766, -73.57882, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H855", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h860 = RoomCoordinate(45.4973844, -73.5787818, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H860", adjCoordinates: {j8F9});

    RoomCoordinate h861 = RoomCoordinate(45.4973862, -73.5786337, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H861", adjCoordinates: {j8F7, j8F8});

    RoomCoordinate h862 = RoomCoordinate(45.4973047, -73.5787902, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H862", adjCoordinates: {j8F10, j8F12});

    RoomCoordinate h863 = RoomCoordinate(45.4973577, -73.578575, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H863", adjCoordinates: {j8F7, j8F8});

    RoomCoordinate h881 = RoomCoordinate(45.4974547, -73.5790906, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H881", adjCoordinates: {j8F4, j8F17});

    Floor eightFloor = Floor('8', polygons: floorPolygons['8'], coordinates: {
      h801,
      h803,
      h805,
      h806,
      h807,
      h811,
      h813,
      h815,
      h817,
      h819,
      h820,
      h821,
      h822,
      h823,
      h825,
      h827,
      h829,
      h831,
      h833,
      h835,
      h837,
      h838,
      h841,
      h843,
      h845,
      h847,
      h849,
      h851,
      h852,
      h853,
      h854
      ,h855,
      h860,
      h861,
      h862,
      h863,
      h881,
      j8F1,
      j8F2,
      j8F3,
      j8F4,
      j8F5,
      j8F6,
      j8F7,
      j8F8,
      j8F9,
      j8F10,
      j8F11,
      j8F12,
      j8F13,
      j8F14,
      j8F15,
      j8F16,
      j8F17
      });
    hall.addFloor(eightFloor);
  }

  void _initHallNinthFloor(Building hall) {
    PortalCoordinate j9F1 = PortalCoordinate(
        45.497223, -73.579356, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F2 = PortalCoordinate(
        45.497282, -73.579296, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F3 = PortalCoordinate(
        45.497279, -73.579218, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F4 = PortalCoordinate(
        45.497151, -73.579210, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F5 = PortalCoordinate(
        45.497247, -73.579120, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F6 = PortalCoordinate(
        45.497305, -73.579054, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F7 = PortalCoordinate(
        45.497353, -73.579043, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F8 = PortalCoordinate(
        45.497390, -73.579003, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F9 = PortalCoordinate(
        45.497422, -73.579075, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F10 = PortalCoordinate(
        45.497456, -73.579144, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F11 = PortalCoordinate(
        45.497488, -73.579169, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F12 = PortalCoordinate(
        45.497650, -73.579018, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F13 = PortalCoordinate(
        45.497562, -73.578834, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F14 = PortalCoordinate(
        45.497503, -73.578712, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F15 = PortalCoordinate(
        45.497111, -73.57118, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F16 = PortalCoordinate(
        45.497042, -73.579145, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F17 = PortalCoordinate(
        45.496957, -73.578869, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F18 = PortalCoordinate(
        45.496972, -73.578892, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F19 = PortalCoordinate(
        45.497154, -73.578731, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F20 = PortalCoordinate(
        45.497352, -73.578536, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F21 = PortalCoordinate(
        45.497334, -73.578493, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F22 = PortalCoordinate(
        45.497424, -73.578703, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F23 = PortalCoordinate(
        45.497409, -73.578684, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F24 = PortalCoordinate(
        45.497246, -73.578840, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F25 = PortalCoordinate(
        45.497218, -73.578863, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F26 = PortalCoordinate(
        45.497289, -73.579012, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F27 = PortalCoordinate(
        45.497300, -73.579003, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F28 = PortalCoordinate(
        45.497191, -73.579165, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F29 = PortalCoordinate(
        45.497047, -73.578826, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F30 = PortalCoordinate(
        45.497442, -73.578995, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F31 = PortalCoordinate(
        45.497408, -73.579041, '9', 'H', 'SGW',
        isDisabilityFriendly: true,
        adjCoordinates: <Coordinate>{},
        type: "PORTAL");

    PortalCoordinate j9F32 = PortalCoordinate(
        45.497084, -73.579120, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F33 = PortalCoordinate(
        45.497077, -73.579111, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F34 = PortalCoordinate(
        45.497052, -73.579032, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F35 = PortalCoordinate(
        45.497207, -73.578683, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F36 = PortalCoordinate(
        45.497319, -73.578772, '9', 'H', 'SGW',
        isDisabilityFriendly: true,
        adjCoordinates: <Coordinate>{},
        type: "PORTAL");

    PortalCoordinate j9F37 = PortalCoordinate(
        45.497364, -73.578729, '9', 'H', 'SGW',
        type: "PORTAL", adjCoordinates: <Coordinate>{});

    j9F1.adjCoordinates = {j9F2, j9F4};
    j9F2.adjCoordinates = {j9F3, j9F1};
    j9F3.adjCoordinates = {j9F2, j9F5};
    j9F4.adjCoordinates = {j9F28, j9F1};
    j9F5.adjCoordinates = {j9F6, j9F28, j9F3};
    j9F6.adjCoordinates = {j9F7, j9F5, j9F26};
    j9F7.adjCoordinates = {j9F8, j9F6};
    j9F8.adjCoordinates = {j9F7, j9F31, j9F30};
    j9F9.adjCoordinates = {j9F31, j9F10};
    j9F10.adjCoordinates = {j9F9, j9F11};
    j9F11.adjCoordinates = {j9F10, j9F12};
    j9F12.adjCoordinates = {j9F11, j9F13};
    j9F13.adjCoordinates = {j9F12, j9F14, j9F30};
    j9F14.adjCoordinates = {j9F13};
    j9F15.adjCoordinates = {j9F32, j9F4};
    j9F16.adjCoordinates = {j9F33};
    j9F17.adjCoordinates = {j9F18};
    j9F18.adjCoordinates = {j9F29, j9F34, j9F17};
    j9F19.adjCoordinates = {j9F35, j9F25, j9F29};
    j9F20.adjCoordinates = {j9F21, j9F23, j9F35};
    j9F21.adjCoordinates = {j9F20};
    j9F22.adjCoordinates = {j9F23};
    j9F23.adjCoordinates = {j9F20, j9F22, j9F37};
    j9F24.adjCoordinates = {j9F36, j9F25};
    j9F25.adjCoordinates = {j9F24, j9F26, j9F19};
    j9F26.adjCoordinates = {j9F27, j9F25, j9F6};
    j9F27.adjCoordinates = {j9F26};
    j9F28.adjCoordinates = {j9F5, j9F4};
    j9F29.adjCoordinates = {j9F19, j9F18};
    j9F30.adjCoordinates = {j9F13, j9F8};
    j9F31.adjCoordinates = {j9F8, j9F9};
    j9F32.adjCoordinates = {j9F33, j9F15};
    j9F33.adjCoordinates = {j9F32, j9F16, j9F34};
    j9F34.adjCoordinates = {j9F33, j9F18};
    j9F35.adjCoordinates = {j9F19, j9F20};
    j9F36.adjCoordinates = {j9F37, j9F24};
    j9F37.adjCoordinates = {j9F23, j9F36};

    RoomCoordinate h965 = RoomCoordinate(45.497205, -73.579329, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H965", adjCoordinates: {j9F1, j9F4});

    RoomCoordinate h921 = RoomCoordinate(45.497380, -73.578606, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H921", adjCoordinates: {j9F20, j9F23});

    Floor ninthFloor = Floor('9', polygons: floorPolygons['9'], coordinates: {
      h965,
      h921,
      j9F1,
      j9F2,
      j9F3,
      j9F4,
      j9F5,
      j9F6,
      j9F7,
      j9F8,
      j9F9,
      j9F10,
      j9F11,
      j9F12,
      j9F13,
      j9F14,
      j9F15,
      j9F16,
      j9F17,
      j9F18,
      j9F19,
      j9F20,
      j9F21,
      j9F22,
      j9F23,
      j9F24,
      j9F25,
      j9F26,
      j9F27,
      j9F28,
      j9F29,
      j9F30,
      j9F31,
      j9F32,
      j9F33,
      j9F34,
      j9F35,
      j9F36,
      j9F37
    });

    hall.addFloor(ninthFloor);
  }
}
