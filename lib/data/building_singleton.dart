import 'dart:math';
import '../model/building.dart';
import '../model/coordinate.dart';
import '../model/floor.dart';
import '../service/map_constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'data_points.dart';
import 'building_list.dart' as building_list_data;

class BuildingSingleton {
  static final BuildingSingleton _instance = BuildingSingleton._internal();

  Map<String, Building> _buildings;

  RoomCoordinate _h8F16; // 8th floor escalator
  RoomCoordinate _h8F12; // 8th floor elevator

  RoomCoordinate get h8F16 => _h8F16;
  RoomCoordinate get h8F12 => _h8F12;

  factory BuildingSingleton() {
    return _instance;
  }

  BuildingSingleton._internal() {
    _buildings = building_list_data.buildings;
    _initHall(_buildings['H']);
  }

  Map<String, Building> get buildings => _buildings;

  List<Building> getBuildingList() {
    var result = <Building>[];
    _buildings.forEach((k, v) => result.add(v));
    return result;
  }

  List<RoomCoordinate> getAllRooms() {
    List<RoomCoordinate> roomList = <RoomCoordinate>[];
    for (Building building in buildings.values) {
      building.floors.forEach((floorName, floor) => floor
          .coordinatesByGivenTypes({"ROOM"}).forEach(
              (room) => roomList.add(room)));
    }
    return roomList;
  }

  Set<Polygon> getOutdoorBuildingHighlights() {
    Set<Polygon> result = {};
    for (var building in buildings.values) {
      List<LatLng> latlngs = <LatLng>[];

      if (building.polygon == null) {
        continue;
      }

      for (var coordinate in building.polygon) {
        latlngs.add(coordinate.toLatLng());
      }

      result.add(Polygon(
          polygonId: PolygonId(building.buildingName),
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
      if (building.buildingName
          .toUpperCase()
          .contains(buildingName.toUpperCase())) {
        if (building.floors != null) {
          var floor = building.floors[floorName];
          if (floor != null && floor.polygons != null) {
            for (List<Coordinate> list in floor.polygons) {
              List<LatLng> points = [];
              list.forEach((coordinate) => points.add(coordinate.toLatLng()));
              Random rnd = Random();
              result.add(Polygon(
                  polygonId:
                      PolygonId('${floor.floorName}-${rnd.nextInt(100000000)}'),
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
      if (building.buildingName
          .toUpperCase()
          .contains(buildingName.toUpperCase())) {
        if (building.floors != null) {
          var floor = building.floors[floorName];
          List<RoomCoordinate> markers =
              floor.coordinatesByGivenTypes({'MARKER'});
          markers.forEach((f) => result.add(Marker(
              markerId: MarkerId(f.roomId),
              infoWindow: InfoWindow(title: f.roomId))));
        }
      }
    }
    return result;
  }

  void _initHall(Building hall) {
    //8th floor portals
    PortalCoordinate j8F1 = PortalCoordinate(
        45.4971949, -73.5793413, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F2 = PortalCoordinate(
        45.4972645, -73.5792733, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j8F3 = PortalCoordinate(
        45.4973532, -73.5791857, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F4 = PortalCoordinate(
        45.4974917, -73.5790559, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j8F5 = PortalCoordinate(
        45.4975589, -73.5789924, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F6 = PortalCoordinate(
        45.4973987, -73.579035, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: true);

    PortalCoordinate j8F7 = PortalCoordinate(
        45.4974122, -73.578687, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F8 = PortalCoordinate(
        45.4973444, -73.578548, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F9 = PortalCoordinate(
        45.4973621, -73.578735, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j8F10 = PortalCoordinate(
        45.4972072, -73.5788831, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F11 = PortalCoordinate(
        45.4971364, -73.5787408, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F12 = PortalCoordinate(
        45.4973283, -73.5787675, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: true);

    PortalCoordinate j8F13 = PortalCoordinate(
        45.497251, -73.5789738, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F14 = PortalCoordinate(
        45.4970442, -73.5788285, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j8F15 = PortalCoordinate(
        45.4969788, -73.5788903, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j8F16 = PortalCoordinate(
        45.4972827, -73.5789415, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j8F17 = PortalCoordinate(
        45.4974342, -73.5791097, '8', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    //9th floor portals
    PortalCoordinate j9F1 = PortalCoordinate(
        45.4972229, -73.5793637, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F2 = PortalCoordinate(
        45.4972848, -73.5793076, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F3 = PortalCoordinate(
        45.4972823, -73.5792232, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F4 = PortalCoordinate(
        45.4971482, -73.5792097, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F5 = PortalCoordinate(
        45.4972032, -73.579156, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j9F6 = PortalCoordinate(
        45.497236, -73.5791237, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F7 = PortalCoordinate(
        45.4969877, -73.5788817, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F8 = PortalCoordinate(
        45.4970442, -73.5788285, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j9F9 = PortalCoordinate(
        45.4971508, -73.5787267, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F10 = PortalCoordinate(
        45.4973393, -73.5785469, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F11 = PortalCoordinate(
        45.4974085, -73.5786857, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F12 = PortalCoordinate(
        45.4973589, -73.5787337, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j9F13 = PortalCoordinate(
        45.4973184, -73.5787723, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: true);

    PortalCoordinate j9F14 = PortalCoordinate(
        45.4972188, -73.5788677, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F15 = PortalCoordinate(
        45.4972611, -73.5789558, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F16 = PortalCoordinate(
        45.4972815, -73.5789366, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    PortalCoordinate j9F17 = PortalCoordinate(
        45.4973084, -73.5790534, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F18 = PortalCoordinate(
        45.4973231, -73.5790391, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F19 = PortalCoordinate(
        45.4973374, -73.5790509, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F20 = PortalCoordinate(
        45.4973767, -73.5790131, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F21 = PortalCoordinate(
        45.4973955, -73.5790524, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: true);

    PortalCoordinate j9F22 = PortalCoordinate(
        45.4974316, -73.5791262, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F23 = PortalCoordinate(
        45.4974894, -73.5791726, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F24 = PortalCoordinate(
        45.4974402, -73.5789529, '9', 'H', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "PORTAL",
        isDisabilityFriendly: false);

    j8F1.adjCoordinates = {j8F2, j8F15};
    j8F2.adjCoordinates = {j8F1, j8F3, j9F5};
    j8F3.adjCoordinates = {j8F2, j8F13, j8F17};
    j8F4.adjCoordinates = {j8F5, j8F17, j9F24};
    j8F5.adjCoordinates = {j8F4, j8F7};
    j8F6.adjCoordinates = {j8F17, j9F21};
    j8F7.adjCoordinates = {j8F5, j8F8, j8F9};
    j8F8.adjCoordinates = {j8F7, j8F11};
    j8F9.adjCoordinates = {j8F7, j8F12, j9F12};
    j8F10.adjCoordinates = {j8F11, j8F12, j8F13};
    j8F11.adjCoordinates = {j8F8, j8F10, j8F14};
    j8F12.adjCoordinates = {j8F9, j8F10, j9F13};
    j8F13.adjCoordinates = {j8F3, j8F10, j8F16};
    j8F14.adjCoordinates = {j8F11, j8F15, j9F8};
    j8F15.adjCoordinates = {j8F14, j8F1};
    j8F16.adjCoordinates = {j8F13, j9F16};
    j8F17.adjCoordinates = {j8F3, j8F4, j8F6};

    j9F1.adjCoordinates = {j9F2, j9F4};
    j9F2.adjCoordinates = {j9F3, j9F1};
    j9F3.adjCoordinates = {j9F2, j9F6};
    j9F4.adjCoordinates = {j9F1, j9F5, j9F7};
    j9F5.adjCoordinates = {j9F4, j9F6, j8F2};
    j9F6.adjCoordinates = {j9F3, j9F5, j9F17};
    j9F7.adjCoordinates = {j9F4, j9F8};
    j9F8.adjCoordinates = {j9F7, j9F9, j8F14};
    j9F9.adjCoordinates = {j9F8, j9F14, j9F10};
    j9F10.adjCoordinates = {j9F11, j9F9};
    j9F11.adjCoordinates = {j9F10, j9F12};
    j9F12.adjCoordinates = {j9F11, j9F13, j8F9};
    j9F13.adjCoordinates = {j9F12, j9F14, j8F12};
    j9F14.adjCoordinates = {j9F9, j9F15, j9F13};
    j9F15.adjCoordinates = {j9F14, j8F16, j9F17};
    j9F16.adjCoordinates = {j9F15, j8F16};
    j9F17.adjCoordinates = {j9F6, j9F18};
    j9F18.adjCoordinates = {j9F17, j9F19};
    j9F19.adjCoordinates = {j9F18, j9F20};
    j9F20.adjCoordinates = {j9F19, j9F24, j9F21};
    j9F21.adjCoordinates = {j9F20, j9F22, j8F6};
    j9F22.adjCoordinates = {j9F21, j9F23};
    j9F23.adjCoordinates = {j9F22};
    j9F24.adjCoordinates = {j9F20, j8F4};

    RoomCoordinate h811 = RoomCoordinate(
        45.4970862, -73.5787884, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H811", adjCoordinates: {j8F11, j8F14});

    RoomCoordinate h813 = RoomCoordinate(
        45.4970359, -73.5788358, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H813", adjCoordinates: {j8F14, j8F15});

    RoomCoordinate h815 = RoomCoordinate(
        45.4969912, -73.5788789, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H815", adjCoordinates: {j8F14, j8F15});

    RoomCoordinate h817 = RoomCoordinate(
        45.4969788, -73.5788902, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H817", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h819 = RoomCoordinate(
        45.4969858, -73.5789055, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H819", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h820 = RoomCoordinate(
        45.497047, -73.5790332, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H820", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h821 = RoomCoordinate(
        45.4970194, -73.5789754, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H821", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h822 = RoomCoordinate(
        45.4971302, -73.5792069, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H822", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h823 = RoomCoordinate(
        45.4970505, -73.5790399, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H823", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h825 = RoomCoordinate(
        45.4970839, -73.5791094, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H825", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h827 = RoomCoordinate(
        45.4971167, -73.5791776, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H827", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h829 = RoomCoordinate(
        45.4971699, -73.5792892, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H829", adjCoordinates: {j8F1, j8F15});

    RoomCoordinate h831 = RoomCoordinate(
        45.4971889, -73.5793479, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H831", adjCoordinates: {j8F1});

    RoomCoordinate h835 = RoomCoordinate(
        45.4972492, -73.5792886, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H835", adjCoordinates: {j8F1, j8F2});

    RoomCoordinate h833 = RoomCoordinate(
        45.4972025, -73.579334, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H833", adjCoordinates: {j8F1, j8F2});

    RoomCoordinate h837 = RoomCoordinate(
        45.4973005, -73.5792377, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H837", adjCoordinates: {j8F3, j8F2});

    RoomCoordinate h838 = RoomCoordinate(
        45.4973915, -73.5791498, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H838", adjCoordinates: {j8F3, j8F17});

    RoomCoordinate h841 = RoomCoordinate(
        45.4974017, -73.5791402, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H841", adjCoordinates: {j8F3, j8F17});

    RoomCoordinate h843 = RoomCoordinate(
        45.4974606, -73.5790849, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H843", adjCoordinates: {j8F4, j8F17});

    RoomCoordinate h845 = RoomCoordinate(
        45.4975062, -73.5790422, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H845", adjCoordinates: {j8F4, j8F5});

    RoomCoordinate h847 = RoomCoordinate(
        45.4975497, -73.5790013, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H847", adjCoordinates: {j8F4, j8F5});

    RoomCoordinate h849 = RoomCoordinate(
        45.4975645, -73.5789853, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H849", adjCoordinates: {j8F5});

    RoomCoordinate h851 = RoomCoordinate(
        45.4975695, -73.5789792, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H851", adjCoordinates: {j8F5});

    RoomCoordinate h852 = RoomCoordinate(
        45.497505, -73.5788792, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H852", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h853 = RoomCoordinate(
        45.4975315, -73.5789348, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H853", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h854 = RoomCoordinate(
        45.4974968, -73.5788628, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H854", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h855 = RoomCoordinate(45.4974766, -73.57882, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H855", adjCoordinates: {j8F5, j8F7});

    RoomCoordinate h860 = RoomCoordinate(
        45.4973844, -73.5787818, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H860", adjCoordinates: {j8F9});

    RoomCoordinate h862 = RoomCoordinate(
        45.4973047, -73.5787902, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H862", adjCoordinates: {j8F10, j8F12});

    RoomCoordinate h881 = RoomCoordinate(
        45.4974547, -73.5790906, '8', 'H', 'SGW',
        type: "ROOM", roomId: "H881", adjCoordinates: {j8F4, j8F17});

    _h8F16 = RoomCoordinate(
        // 8th floor escalators
        45.4972828,
        -73.5789415,
        '8',
        'H',
        'SGW',
        adjCoordinates: {j8F16});

    _h8F12 = RoomCoordinate(
        // 8th floor elevator
        45.4973283,
        -73.5787676,
        '8',
        'H',
        'SGW',
        adjCoordinates: {j8F12});

    Floor eightFloor = Floor('8', polygons: floorPolygons['8'], coordinates: {
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
      h854,
      h855,
      h860,
      h862,
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
      j8F17,
      _h8F16,
      _h8F12
    });
    hall.addFloor(eightFloor);

    RoomCoordinate h965 = RoomCoordinate(45.497379, -73.578617, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H965", adjCoordinates: {j9F10, j9F11});

    RoomCoordinate h931 = RoomCoordinate(45.497209, -73.579341, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H931", adjCoordinates: {j9F1, j9F4});

    Floor ninthFloor = Floor('9', polygons: floorPolygons['9'], coordinates: {
      h965,
      h931,
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
    });

    hall.addFloor(ninthFloor);
  }
}
