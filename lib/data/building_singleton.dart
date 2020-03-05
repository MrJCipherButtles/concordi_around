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
    _buildings.add(ev);

    Building jmsb = Building("John Molson School of Business",
        coordinate: Coordinate(45.4954, -73.57909, "0", "JMSB", "SGW"));
    _buildings.add(jmsb);

    Building gm = Building("Pavillon Guy-De Maisonneuve",
        coordinate: Coordinate(45.49589, -73.5785, "0", "GM", "SGW"));
    _buildings.add(gm);

    Building hall = Building('Henry F. Hall',
        coordinate: Coordinate(45.49726, -73.57893, "0", "Hall", "SGW"));
    initHallNinthFloor(hall);
    initHallEightFloor(hall);
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

  Set<Polygon> getFloorPolygon(String buildingName, String floorName) {
    Set<Polygon> result = {};
    for(var building in _buildings) {
      if(building.building.toUpperCase().contains(buildingName.toUpperCase())) {
        if(building.floors != null) {
          var floor = building.floors[floorName];
          if(floor != null && floor.polygons != null) {
            for(List<Coordinate> list in  floor.polygons) {
              List<LatLng> points = new List();
              list.forEach((coordinate) => points.add(coordinate.toLatLng()));
              result.add(Polygon(
                polygonId: PolygonId('1'),
                points: points,
                fillColor: COLOR_CONCORDIA,
                strokeWidth: 2
              ));
            }
          }
        }
      }
    }
    return result;
  }

  void initHallEightFloor(Building hall) {
    Floor eightFloor = Floor('8');
    eightFloor.polygons = {
      [
        Coordinate(45.4970685, -73.578644, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970682, -73.5786433, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970971, -73.5786158, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970976, -73.5786167, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970685, -73.578644, '8', 'Hall', 'SGW', type: 'POLYGON')
      ],
      [
        Coordinate(45.4971131, -73.5787376, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4969664, -73.5788754, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4969521, -73.5788462, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4969385, -73.5788596, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4969493, -73.5788827, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4969852, -73.5789582, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970177, -73.5790219, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970755, -73.5791429, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971199, -73.5792344, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971782, -73.5793551, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971641, -73.5793682, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971742, -73.579388, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972398, -73.5793276, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972886, -73.5792804, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973406, -73.5792331, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497389, -73.5793347, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971787, -73.5795319, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4968496, -73.5788498, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970685, -73.578644, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970685, -73.578644, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971131, -73.5787376, '8', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.4970976, -73.5786167, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973807, -73.5783506, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4977088, -73.5790352, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974353, -73.5792901, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973871, -73.5791878, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497522, -73.5790618, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4975887, -73.5790007, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4976198, -73.5789642, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4976043, -73.5789307, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4975939, -73.5789404, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4975979, -73.5789501, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4975744, -73.5789729, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974969, -73.578811, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974299, -73.5786712, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973596, -73.5785236, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973709, -73.5785122, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973512, -73.5784707, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973378, -73.5784841, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973483, -73.5785082, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972452, -73.5786055, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972224, -73.5785582, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497213, -73.5785669, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972379, -73.5786195, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971425, -73.5787084, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970976, -73.5786167, '8', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.4971992, -73.5793012, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971143, -73.5791262, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971357, -73.5791054, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971171, -73.5790669, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970946, -73.5790877, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970704, -73.5790337, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970922, -73.5790136, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970763, -73.5789807, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970544, -73.5790028, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4970027, -73.5788962, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971247, -73.5787829, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972184, -73.578977, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972727, -73.5790897, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973193, -73.5791879, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973002, -73.5792064, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497264, -73.5791326, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972542, -73.5791423, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972896, -73.5792167, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971992, -73.5793012, '8', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.4972189, -73.5788412, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971745, -73.5787507, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497205, -73.5787215, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4971996, -73.5787095, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973388, -73.5785777, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973505, -73.5786008, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973895, -73.5786806, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972189, -73.5788412, '8', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.4973657, -73.5791449, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973281, -73.5790678, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973596, -73.5790373, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973349, -73.5789853, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973039, -73.5790165, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972433, -73.5788911, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497275, -73.5788606, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972708, -73.5788512, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972901, -73.5788345, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4972879, -73.5788294, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497366, -73.5787563, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974064, -73.5788361, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974137, -73.5788274, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973761, -73.5787473, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974064, -73.5787181, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974806, -73.57887, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974776, -73.578874, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974917, -73.5789029, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974952, -73.5788998, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4975352, -73.578985, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974322, -73.5790819, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973958, -73.5790044, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973796, -73.5790199, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4974094, -73.5790836, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973791, -73.5791134, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973852, -73.5791272, '8', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.4973657, -73.5791449, '8', 'Hall', 'SGW', type: 'POLYGON'),
      ]
    };

    hall.addFloor(eightFloor);
  }

  void initHallNinthFloor(Building hall) {
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

    ninthFloor.polygons = {
      [
        Coordinate(45.497224, -73.579342, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497275, -73.579296, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497272, -73.579235, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497235, -73.579161, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497164, -73.579227, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497224, -73.579342, '9', 'Hall', 'SGW', type: 'POLYGON')
      ],
      [
        Coordinate(45.497161, -73.579152, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497286, -73.579035, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497152, -73.578760, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497005, -73.578897, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497055, -73.579002, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497078, -73.578985, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497094, -73.579019, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497073, -73.579038, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497096, -73.579086, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497119, -73.579068, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497161, -73.579152, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497173, -73.578739, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497221, -73.578838, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497391, -73.578680, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497339, -73.578579, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497222, -73.578693, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497229, -73.578711, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497218, -73.578722, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497209, -73.578707, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497173, -73.578739, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497467, -73.579142, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497486, -73.579157, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497633, -73.579014, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497555, -73.578855, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497400, -73.579007, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497467, -73.579142, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497347, -73.579026, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497550, -73.578833, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497491, -73.578709, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497533, -73.578672, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497491, -73.578583, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497413, -73.578662, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497433, -73.578705, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497418, -73.578717, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497413, -73.578706, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497268, -73.578841, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497318, -73.578952, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497312, -73.578959, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497347, -73.579026, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497421, -73.578649, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497491, -73.578583, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497374, -73.578342, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.496833, -73.578851, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497168, -73.579544, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497338, -73.579385, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497298, -73.579309, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497221, -73.579376, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497125, -73.579184, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497103, -73.579201, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497069, -73.579132, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497040, -73.579158, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497032, -73.579143, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497062, -73.579113, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.496942, -73.578862, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.496958, -73.578847, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.496969, -73.578865, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497336, -73.578521, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497321, -73.578489, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497333, -73.578478, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497349, -73.578512, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497355, -73.578508, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497421, -73.578649, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497338, -73.579385, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497514, -73.579216, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497496, -73.579177, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497488, -73.579184, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497362, -73.579107, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497356, -73.579112, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497337, -73.579072, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497285, -73.579125, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497301, -73.579162, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497293, -73.579170, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497293, -73.579300, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497338, -73.579385, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ],
      [
        Coordinate(45.497533, -73.578672, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497709, -73.579033, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497514, -73.579216, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497496, -73.579177, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497663, -73.579019, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497505, -73.578697, '9', 'Hall', 'SGW', type: 'POLYGON'),
        Coordinate(45.497533, -73.578672, '9', 'Hall', 'SGW', type: 'POLYGON'),
      ]
    };
    hall.addFloor(ninthFloor);
  }
}
