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
    _buildings.add(ev);
    Building jmsb = Building("John Molson School of Business",
        coordinate: Coordinate(45.4954, -73.57909, "0", "JMSB", "SGW"));
    _buildings.add(jmsb);
    Building gm = Building("Pavillon Guy-De Maisonneuve",
        coordinate: Coordinate(45.49589, -73.5785, "0", "GM", "SGW"));
    _buildings.add(gm);
    initHallNinthFloor();
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

  void initHallNinthFloor() {
    Building hall = Building('Henry F. Hall',
        coordinate: Coordinate(45.49726, -73.57893, "0", "Hall", "SGW"));

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
    _buildings.add(hall);
  }
}
