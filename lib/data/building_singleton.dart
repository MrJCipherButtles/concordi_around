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
        coordinate: Coordinate(45.49558, -73.57801, "0", "EV", "SGW", type: "BUILDING"));
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
        coordinate: Coordinate(45.49726, -73.57893, "0", "H", "SGW"));
    _initHall(hall);
    _initHallNinthFloor(hall);
    initHallEightFloor(hall);
    _buildings.add(hall);

    //LOYOLA
    Building vl = Building('Vanier Library',
        coordinate: Coordinate(45.459053, -73.638683, "0", "Vanier Library", "LOY"));
    _initVL(vl);
    _buildings.add(vl);

    Building fc = Building('F.C Smith Building',
        coordinate: Coordinate(45.458563, -73.639277, "0", "FC", "LOY"));
    _initFC(fc);
    _buildings.add(fc);

    Building pb = Building('Psychology Building',
        coordinate: Coordinate(45.459068, -73.640577, "0", "PB", "LOY"));
    _initPB(pb);
    _buildings.add(pb);

    Building cj = Building('Communication Studies and Journalism Building',
        coordinate: Coordinate(45.457523, -73.640375, "0", "CJ", "LOY"));
    _initCJ(cj);
    _buildings.add(cj);

    Building sp = Building('Richard J. Renaud Science Complex',
        coordinate: Coordinate(45.457832, -73.641494, "0", "SP", "LOY"));
    _initSP(sp);
    _buildings.add(sp);

    Building cb = Building('Central Building',
        coordinate: Coordinate(45.458306, -73.640352, "0", "CB", "LOY"));
    _initCB(cb);
    _buildings.add(cb);

    Building psb = Building('Physical Service Building',
        coordinate: Coordinate(45.459647, -73.639784, "0", "PSB", "LOY"));
    _initPSB(psb);
    _buildings.add(psb);
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

  void _initVL(Building vl) {
    vl.polygon = [
      Coordinate(45.4589907, -73.639125, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590949, -73.6390404, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590782, -73.6389969, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591363, -73.6389515, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591433, -73.6389522, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591544, -73.63898, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592204, -73.6389274, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592039, -73.6388858, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590958, -73.6389695, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590902, -73.6389692, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590516, -73.6388686, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588595, -73.639019, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588532, -73.6390193, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588377, -73.6389784, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588349, -73.6389811, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588283, -73.6389817, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586304, -73.6384667, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587178, -73.6383989, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587044, -73.6383631, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458866, -73.6382363, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588528, -73.6382021, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588869, -73.638175, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588688, -73.638126, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4589022, -73.6380998, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4588826, -73.6380479, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4589106, -73.6380257, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4589014, -73.6380006, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459038, -73.6378947, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590449, -73.6378947, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459051, -73.6379105, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4590813, -73.6378877, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459074, -73.6378672, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591025, -73.6378454, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591086, -73.6378461, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591345, -73.6379145, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591286, -73.6379192, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591367, -73.6379397, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591393, -73.637938, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591449, -73.6379386, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592197, -73.638132, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459139, -73.6381962, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593183, -73.638662, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593084, -73.63867, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.45949, -73.6391355, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459367, -73.6392314, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593602, -73.6392324, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593522, -73.6392113, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593406, -73.63922, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4593336, -73.639221, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459319, -73.6391828, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592701, -73.6392214, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459311, -73.639324, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592395, -73.639381, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4592334, -73.6393813, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459216, -73.6393357, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.459113, -73.639419, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4591062, -73.6394193, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4589907, -73.639125, "0", "VL", "LOY", type: "POLYGON")
    ];
  }

  void _initFC(Building fc) {
    fc.polygon = [
      Coordinate(45.4586283, -73.6396647, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586002, -73.639592, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585967, -73.6395947, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585891, -73.6395954, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585826, -73.639577, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585607, -73.6395927, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458555, -73.6395924, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585395, -73.6395867, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585301, -73.6395612, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585355, -73.6395397, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585264, -73.6395149, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.45852, -73.639519, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585165, -73.6395186, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585113, -73.639519, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584979, -73.6394824, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585007, -73.6394801, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584868, -73.6394432, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585144, -73.6394224, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585111, -73.6394117, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585179, -73.6394066, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585014, -73.6393641, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584967, -73.6393644, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458493, -73.639354, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584965, -73.639351, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584784, -73.6393034, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584734, -73.6393037, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584692, -73.6392913, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458473, -73.6392883, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458457, -73.6392464, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584469, -73.6392544, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584424, -73.6392548, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584184, -73.6391904, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584321, -73.6391803, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584248, -73.6391602, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584323, -73.6391548, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584109, -73.6390999, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584281, -73.6390868, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4584154, -73.6390539, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4583942, -73.63907, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4583831, -73.6390398, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585201, -73.638936, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585312, -73.6389652, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585095, -73.6389823, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585229, -73.6390138, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585373, -73.6390027, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585413, -73.639003, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585612, -73.6390552, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458569, -73.6390492, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585786, -73.6390509, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585821, -73.6390579, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4585908, -73.6390579, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586134, -73.6390663, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586256, -73.6390954, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586195, -73.6391276, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586089, -73.6391364, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586682, -73.6392918, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458671, -73.6392895, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586799, -73.6392891, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586893, -73.6393106, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458698, -73.6393042, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587047, -73.6393041, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587078, -73.6393121, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587304, -73.6392953, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587449, -73.6393342, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587221, -73.6393517, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587252, -73.63936, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587113, -73.6393704, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587261, -73.639412, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587158, -73.6394197, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587414, -73.6394854, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587366, -73.6394899, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587298, -73.6394956, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.458758, -73.6395704, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4587479, -73.639624, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586686, -73.6396828, "0", "VL", "LOY", type: "POLYGON"),
      Coordinate(45.4586283, -73.6396647, "0", "VL", "LOY", type: "POLYGON")
    ];
  }

  void _initPB(Building pb) {
    pb.polygon = [
      Coordinate(45.4592896, -73.6405591, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592677, -73.6405788, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592579, -73.6405879, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.459248, -73.6405963, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592459, -73.6405959, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592075, -73.6406238, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4591991, -73.6406238, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4591812, -73.6405762, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.458851, -73.640834, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4588487, -73.6408333, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4588003, -73.6407111, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4588226, -73.6406946, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4587963, -73.6406266, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4587984, -73.6406246, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.45873, -73.6404455, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4587644, -73.6404184, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4587566, -73.6403976, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4589857, -73.6402201, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4589937, -73.6402205, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590026, -73.640244, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590306, -73.6402225, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590247, -73.6402071, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590581, -73.6401819, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590553, -73.6401749, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.459093, -73.6401463, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4590953, -73.640152, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4591205, -73.6401336, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4591276, -73.6401342, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592193, -73.6403719, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.459226, -73.6403722, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592475, -73.640428, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592416, -73.6404327, "0", "PB", "LOY", type: "POLYGON"),
      Coordinate(45.4592896, -73.6405591, "0", "PB", "LOY", type: "POLYGON")
    ];
  }

  void _initCJ(Building cj) {
    cj.polygon = [
      Coordinate(45.4573342, -73.6407167, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573033, -73.6406389, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572789, -73.6406576, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4571763, -73.6403934, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574108, -73.640207, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573607, -73.6400756, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573113, -73.6400491, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573057, -73.6400729, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.457214, -73.6400173, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572111, -73.6399894, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572257, -73.639919, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572295, -73.6398848, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572594, -73.6398272, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4572798, -73.6398024, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573062, -73.6397842, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573316, -73.6397692, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573588, -73.6397628, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573866, -73.6397618, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574073, -73.6397648, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574299, -73.6397718, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574807, -73.6398208, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574632, -73.6399535, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574463, -73.6399451, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.457435, -73.6400286, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4574844, -73.6401502, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4576217, -73.6400465, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4577259, -73.6403151, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4577543, -73.6402923, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4578312, -73.6404854, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4576511, -73.6406319, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.457597, -73.6405025, "0", "CJ", "LOY", type: "POLYGON"),
      Coordinate(45.4573342, -73.6407167, "0", "CJ", "LOY", type: "POLYGON")
    ];
  }

  void _initSP(Building sp) {
    sp.polygon = [
      Coordinate(45.4569834, -73.6408299, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4572017, -73.6406562, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4575242, -73.641472, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4579077, -73.6411693, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4578931, -73.6411317, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4579792, -73.641064, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4579976, -73.6411143, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.458316, -73.6408618, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4583395, -73.6409215, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4581935, -73.641037, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4582558, -73.6412009, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4581789, -73.6412623, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4582083, -73.641337, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4582767, -73.6412837, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.458327, -73.6414144, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4576729, -73.641925, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4576409, -73.6418452, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4574377, -73.6420024, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4572094, -73.641413, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4571847, -73.6414317, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4571682, -73.6413908, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.457179, -73.6413821, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4571482, -73.6413047, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4571595, -73.6412953, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4570415, -73.6409935, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4570173, -73.6410119, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4569961, -73.6409569, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4570248, -73.6409348, "0", "SP", "LOY", type: "POLYGON"),
      Coordinate(45.4569834, -73.6408299, "0", "SP", "LOY", type: "POLYGON"),
    ];
  }

  void _initCB(Building cb) {
    cb.polygon = [
      Coordinate(45.4584858, -73.6413179, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585379, -73.6412766, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585264, -73.6412461, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585471, -73.6412297, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585122, -73.6411395, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584635, -73.641177, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584346, -73.6411988, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458428, -73.6411995, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583827, -73.6410782, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584729, -73.6410075, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584146, -73.6408526, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584648, -73.6408139, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584409, -73.6407533, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583874, -73.6407931, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583789, -73.6407934, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.45829, -73.6405624, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582804, -73.6405634, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581664, -73.6402607, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581728, -73.6402557, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580799, -73.6400141, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581041, -73.6399953, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580935, -73.6399665, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581225, -73.6399443, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581114, -73.6399145, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581029, -73.6399199, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.45809, -73.6399209, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580891, -73.6399178, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579741, -73.640007, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579971, -73.6400677, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579884, -73.6400737, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579844, -73.6400754, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579861, -73.6400784, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579235, -73.640124, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579111, -73.640124, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4577991, -73.6398263, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578215, -73.6398105, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578236, -73.6397957, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578497, -73.6397766, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578546, -73.6397773, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578617, -73.6397803, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578753, -73.6397689, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4578866, -73.6397699, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579012, -73.6398092, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579031, -73.6398075, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579141, -73.6398078, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579242, -73.6398306, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580232, -73.6397542, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580232, -73.6397418, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580002, -73.6396818, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580035, -73.6396794, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4579826, -73.6396244, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580395, -73.6395813, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580416, -73.6395816, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580632, -73.6396345, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580655, -73.6396332, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580721, -73.6396335, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4580942, -73.6396901, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581067, -73.6396898, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582031, -73.6396157, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581902, -73.6395812, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582015, -73.6395735, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581831, -73.6395265, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582092, -73.6395068, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582118, -73.639493, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582375, -73.6394735, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582418, -73.6394742, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582474, -73.6394769, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582589, -73.6394685, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582709, -73.6394688, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583829, -73.6397655, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583092, -73.639822, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582977, -73.639823, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582791, -73.639773, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581651, -73.6398612, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581694, -73.6398699, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458152, -73.639884, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4581736, -73.6399417, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582206, -73.6399048, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4582296, -73.6399061, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583208, -73.6401429, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4583302, -73.6401422, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584448, -73.6404453, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584389, -73.64045, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584798, -73.6405549, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584782, -73.6405569, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458489, -73.6405841, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584909, -73.6405854, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584977, -73.6406002, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585024, -73.6406122, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585003, -73.6406136, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585045, -73.640625, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585064, -73.6406253, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585174, -73.6406525, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585156, -73.6406538, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585268, -73.6406853, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584932, -73.6407122, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585168, -73.6407737, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585387, -73.6407569, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585441, -73.6407566, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585909, -73.6408773, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458684, -73.6408062, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458688, -73.6408066, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587038, -73.6408508, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587, -73.6408535, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587075, -73.6408729, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.45872, -73.6409025, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587301, -73.6409293, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587284, -73.6409306, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587407, -73.640962, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587348, -73.6409667, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587661, -73.6410481, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587847, -73.6410337, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4587872, -73.641034, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.458823, -73.6411296, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4588032, -73.6411444, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4588084, -73.6411588, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4586494, -73.6412826, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4586465, -73.6412836, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4586418, -73.6412705, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585103, -73.6413739, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4585072, -73.6413742, "0", "CB", "LOY", type: "POLYGON"),
      Coordinate(45.4584858, -73.6413179, "0", "CB", "LOY", type: "POLYGON")
    ];
  }

  void _initPSB(Building psb) {
    psb.polygon = [
      Coordinate(45.4596084, -73.6401582, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4594136, -73.6396543, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4594439, -73.6396309, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.459404, -73.6395277, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4593396, -73.6395788, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4593332, -73.6395795, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4592864, -73.6394564, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4595774, -73.6392283, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4595835, -73.6392297, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4596277, -73.6393453, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4596641, -73.6393171, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.459671, -73.6393181, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4599866, -73.6401346, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4598688, -73.6402271, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4598627, -73.6402271, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4598524, -73.6402013, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4597117, -73.6403123, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4597054, -73.6403126, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4596385, -73.640137, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4596141, -73.6401578, "0", "PSB", "LOY", type: "POLYGON"),
      Coordinate(45.4596084, -73.6401582, "0", "PSB", "LOY", type: "POLYGON")
    ];
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
        45.497218, -73.578863, '9', 'Hall', 'SGW',
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

    RoomCoordinate h965 = RoomCoordinate(
        45.497205, -73.579329, '9', 'H', 'SGW',
        type: "ROOM", roomId: "H965", adjCoordinates: {j9F1, j9F4});

    RoomCoordinate h921 = RoomCoordinate(
        45.497380, -73.578606, '9', 'H', 'SGW',
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
