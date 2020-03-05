import 'package:concordi_around/services/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/building.dart';
import '../models/coordinate.dart';
import '../models/floor.dart';

class BuildingSingleton {
  static final BuildingSingleton _instance = BuildingSingleton._internal();

  List<Building> _buildings = [];

  factory BuildingSingleton() {
    return _instance;
  }

  BuildingSingleton._internal() {
    Building ev = Building("Engineering, Computer Science and Visual Arts",
        coordinate: Coordinate(45.49558, -73.57801, "0", "EV", "SGW"));
    _initEV(ev);
    _buildings.add(ev);

    Building jmsb = Building("John Molson School of Business",
        coordinate: Coordinate(45.4954, -73.57909, "0", "JMSB", "SGW"));
    _initJMSB(jmsb);
    _buildings.add(jmsb);

    Building gm = Building("Pavillon Guy-De Maisonneuve",
        coordinate: Coordinate(45.49589, -73.5785, "0", "GM", "SGW"));
    _initGM(gm);
    _buildings.add(gm);

    Building jw = Building("J.W McConell Building",
        coordinate: Coordinate(45.496865, -73.578041, "0", "JW", "SGW"));
    _initJW(jw);
    _buildings.add(jw);

    Building hall = Building('Henry F. Hall',
        coordinate: Coordinate(45.49726, -73.57893, "0", "Hall", "SGW"));
    _initHall(hall);
    _initHallNinthFloor(hall);
    _buildings.add(hall);
  }

  List<Building> get buildings => _buildings;

  List<RoomCoordinate> getAllRooms() {
    List<RoomCoordinate> roomList = <RoomCoordinate>[];
    for (Building building in this.buildings) {
      building.floors.forEach((floorName, floor) => floor
          .coordinatesByGivenTypes({"ROOM"}).forEach(
              (room) => roomList.add(room)));
    }
    return roomList;
  }

  void _initEV(Building ev) {
    ev.polygon = [
      Coordinate(45.4955953, -73.5787636, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.495247, -73.5780203, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4952658, -73.5780019, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4952479, -73.5779154, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4952336, -73.5779134, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4952385, -73.5778775, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4952994, -73.577796, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4953539, -73.5777437, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.495356, -73.5776964, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4954475, -73.5776083, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4954926, -73.5776103, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4955504, -73.577555, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4955384, -73.5775285, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4958294, -73.5772509, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4958341, -73.5772529, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4960503, -73.5777068, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4957325, -73.578014, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4959605, -73.5784974, "0", "EV", "SGW", type: "POLYGON"),
      Coordinate(45.4956888, -73.578763, "0", "EV", "SGW", type: "POLYGON")
    ];
  }

  void _initJMSB(Building jmsb) {
    jmsb.polygon = [
      Coordinate(45.4953572, -73.5793665, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4952249, -73.5791198, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4951762, -73.5791704, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4951671, -73.5791707, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4950061, -73.5788234, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.495038, -73.5787909, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4950044, -73.5787359, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4951859, -73.5785257, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.495196, -73.5785263, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4954493, -73.5789619, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4955283, -73.5792006, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4953671, -73.5793669, "0", "JMSB", "SGW", type: "POLYGON"),
      Coordinate(45.4953572, -73.5793665, "0", "JMSB", "SGW", type: "POLYGON"),
    ];
  }

  void _initGM(Building gm) {
    gm.polygon = [
      Coordinate(45.4959353, -73.5784446, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4959459, -73.5784339, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4959536, -73.5784346, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4961148, -73.5787682, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4961172, -73.5787665, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4961365, -73.5788087, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4957877, -73.5791467, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4957804, -73.5791464, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.495763, -73.5791081, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4957804, -73.57909, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4956255, -73.5787641, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4956888, -73.578763, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4959605, -73.5784974, "0", "GM", "SGW", type: "POLYGON"),
      Coordinate(45.4959353, -73.5784446, "0", "GM", "SGW", type: "POLYGON"),
    ];
  }

  void _initJW(Building jw) {
    jw.polygon = [
      Coordinate(45.4967514, -73.5785787, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4967289, -73.5785794, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4967134, -73.5785438, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4966899, -73.5785666, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4966682, -73.5785673, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4962556, -73.5776989, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4964976, -73.5774642, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4965174, -73.5774649, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4965963, -73.5776386, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4966372, -73.577601, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4966147, -73.5775554, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4968915, -73.5772939, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969131, -73.5772932, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970287, -73.5775387, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969977, -73.5775688, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970179, -73.5776131, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.49704, -73.5775869, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970621, -73.5775883, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4971354, -73.5777459, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970917, -73.5777901, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970964, -73.5778062, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4971049, -73.5777975, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4971223, -73.5778357, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4971406, -73.5778163, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4971622, -73.5778183, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4972807, -73.5780563, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970391, -73.5782957, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970175, -73.5782957, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4970076, -73.5782696, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.496986, -73.5782944, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969639, -73.5782964, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.496947, -73.5782595, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969164, -73.578291, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969333, -73.5783299, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4968906, -73.5783695, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4969112, -73.5784157, "0", "JW", "SGW", type: "POLYGON"),
      Coordinate(45.4967514, -73.5785787, "0", "JW", "SGW", type: "POLYGON")
    ];
  }

  void _initHall(Building hall) {
    hall.polygon = [
      Coordinate(45.4977298, -73.579034, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4971832, -73.579545, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4971639, -73.5795423, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4968292, -73.5788483, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4973712, -73.5783373, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4973932, -73.5783393, "0", "HALL", "SGW", type: "POLYGON"),
      Coordinate(45.4977298, -73.579034, "0", "HALL", "SGW", type: "POLYGON"),
    ];
  }

  void _initHallNinthFloor(Building hall) {
    PortalCoordinate j9F1 = PortalCoordinate(
        45.497223, -73.579356, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F2 = PortalCoordinate(
        45.497282, -73.579296, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F3 = PortalCoordinate(
        45.497279, -73.579218, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F4 = PortalCoordinate(
        45.497151, -73.579210, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F5 = PortalCoordinate(
        45.497247, -73.579120, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F6 = PortalCoordinate(
        45.497305, -73.579054, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F7 = PortalCoordinate(
        45.497353, -73.579043, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F8 = PortalCoordinate(
        45.497390, -73.579003, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F9 = PortalCoordinate(
        45.497422, -73.579075, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F10 = PortalCoordinate(
        45.497456, -73.579144, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F11 = PortalCoordinate(
        45.497488, -73.579169, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F12 = PortalCoordinate(
        45.497650, -73.579018, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F13 = PortalCoordinate(
        45.497562, -73.578834, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F14 = PortalCoordinate(
        45.497503, -73.578712, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F15 = PortalCoordinate(
        45.497111, -73.57118, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F16 = PortalCoordinate(
        45.497042, -73.579145, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F17 = PortalCoordinate(
        45.496957, -73.578869, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F18 = PortalCoordinate(
        45.496972, -73.578892, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F19 = PortalCoordinate(
        45.497154, -73.578731, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F20 = PortalCoordinate(
        45.497352, -73.578536, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F21 = PortalCoordinate(
        45.497334, -73.578493, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F22 = PortalCoordinate(
        45.497424, -73.578703, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F23 = PortalCoordinate(
        45.497409, -73.578684, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F24 = PortalCoordinate(
        45.497246, -73.578840, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F25 = PortalCoordinate(
        45.497218, -73.578863, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F26 = PortalCoordinate(
        45.497289, -73.579012, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F27 = PortalCoordinate(
        45.497300, -73.579003, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F28 = PortalCoordinate(
        45.497191, -73.579165, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F29 = PortalCoordinate(
        45.497047, -73.578826, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F30 = PortalCoordinate(
        45.497442, -73.578995, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F31 = PortalCoordinate(
        45.497408, -73.579041, '9', 'Hall', 'SGW',
        isDisabilityFriendly: true,
        adjCoordinates: <Coordinate>{},
        type: "PORTAL");

    PortalCoordinate j9F32 = PortalCoordinate(
        45.497084, -73.579120, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F33 = PortalCoordinate(
        45.497077, -73.579111, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F34 = PortalCoordinate(
        45.497052, -73.579032, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F35 = PortalCoordinate(
        45.497207, -73.578683, '9', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "PORTAL");

    PortalCoordinate j9F36 = PortalCoordinate(
        45.497319, -73.578772, '9', 'Hall', 'SGW',
        isDisabilityFriendly: true,
        adjCoordinates: <Coordinate>{},
        type: "PORTAL");

    PortalCoordinate j9F37 = PortalCoordinate(
        45.497364, -73.578729, '9', 'Hall', 'SGW',
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

    RoomCoordinate h965 = RoomCoordinate(
        45.497205, -73.579329, '9', 'Hall', 'SGW',
        type: "ROOM", roomId: "H965", adjCoordinates: {j9F1, j9F4});

    RoomCoordinate h921 = RoomCoordinate(
        45.497380, -73.578606, '9', 'Hall', 'SGW',
        type: "ROOM", roomId: "H921", adjCoordinates: {j9F20, j9F23});

    Floor ninthFloor = Floor('9', coordinates: {
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

  Set<Polygon> getOutdoorBuildingHighlights() {
    Set<Polygon> result = {};
    for (var building in buildings) {
      List<LatLng> latlngs = new List();

      if(building.polygon == null) {
        continue;
      }
      
      for(var coordinate in building.polygon) {
        latlngs.add(coordinate.toLatLng());
      }
      
      result.add(Polygon(
        polygonId: PolygonId(building.building),
        fillColor: COLOR_CONCORDIA.withOpacity(0.4),
        strokeWidth: 3,
        points: latlngs
      ));
    }
    return result;
  }
}
