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

  void initHallEightFloor() {
PortalCoordinate h8_ll = PortalCoordinate(
        45.496981, -73.578891, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_mm = PortalCoordinate(
       45.497211, -73.578889,
      '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_lm = PortalCoordinate(
        45.497137, -73.578743, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_lr = PortalCoordinate(
        45.497344, -73.578554, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_ur = PortalCoordinate(
        45.497554, -73.578986, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_um = PortalCoordinate(
        45.497352, -73.579189, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_ul = PortalCoordinate(
        45.497196, -73.579331, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_mr = PortalCoordinate(
        45.497410, -73.578689, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    PortalCoordinate h8_stairs_ll = PortalCoordinate(
        45.497045, -73.578830, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "STAIRS");

    PortalCoordinate h8_stairs_ul = PortalCoordinate(
        45.497260, -73.579272, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "STAIRS");

    PortalCoordinate h8_stairs_lr = PortalCoordinate(
        45.497361, -73.578732, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "STAIRS");

    PortalCoordinate h8_stairs_ur = PortalCoordinate(
        45.497526, -73.579021, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "STAIRS");

    PortalCoordinate h8_escalator_down = PortalCoordinate(
        45.497246, -73.578858, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "ESCALATOR-DOWN");

    PortalCoordinate h8_escalator_up = PortalCoordinate(
        45.497328, -73.579028, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "ESCALATOR-UP");

    PortalCoordinate h8_elevator = PortalCoordinate(
        45.497320, -73.578767, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{},
        type: "ELEVATOR",
        isDisabilityFriendly: true);

    RoomCoordinate h8_bathroom_m = RoomCoordinate(
        45.497103, -73.578778, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "BATHROOM-M");

    RoomCoordinate h8_bathroom_f = RoomCoordinate(
        45.497220, -73.578666, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{}, type: "BATHROOM-F");

    RoomCoordinate h817 = RoomCoordinate(
        45.496986, -73.578885, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h815 = RoomCoordinate(
        45.496996, -73.578872, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h819 = RoomCoordinate(
        45.496988, -73.578908, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h813 = RoomCoordinate(
        45.497040, -73.578832, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h811 = RoomCoordinate(
        45.497090, -73.578784, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h807 = RoomCoordinate(
        45.497179, -73.578698, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h805_01 = RoomCoordinate(
        45.497229, -73.578656, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h805_02 = RoomCoordinate(
        45.497229, -73.578656, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h805_03 = RoomCoordinate(
        45.497229, -73.578656, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h803 = RoomCoordinate(
        45.497280, -73.578605, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h801 = RoomCoordinate(
        45.497333, -73.578558, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h867 = RoomCoordinate(
        45.497345, -73.578554, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h865 = RoomCoordinate(
        45.497346, -73.578554, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h863 = RoomCoordinate(
        45.497347, -73.578554, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h861 = RoomCoordinate(
        45.497391, -73.578632, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h859 = RoomCoordinate(
        45.497424, -73.578706, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h857 = RoomCoordinate(
        45.497458, -73.578769, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h855 = RoomCoordinate(
        45.497492, -73.578838, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h853 = RoomCoordinate(
        45.497524, -73.578916, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h851_01 = RoomCoordinate(
        45.497550, -73.578967, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h851_02 = RoomCoordinate(
        45.497551, -73.578967, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h851_03 = RoomCoordinate(
        45.497552, -73.578967, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h849 = RoomCoordinate(
        45.497553, -73.578986, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h847 = RoomCoordinate(
        45.497555, -73.578986, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h845 = RoomCoordinate(
        45.497501, -73.579048, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h843 = RoomCoordinate(
        45.497448, -73.579099, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h841 = RoomCoordinate(
        45.497399, -73.579144, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h837 = RoomCoordinate(
        45.497304, -73.579233, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h835 = RoomCoordinate(
        45.497251, -73.579284, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h833 = RoomCoordinate(
        45.497193, -73.579331, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h831 = RoomCoordinate(
        45.497195, -73.579331, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h899_51 = RoomCoordinate(
        45.497194, -73.579331, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h829 = RoomCoordinate(
        45.497155, -73.579263, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h827 = RoomCoordinate(
        45.497119, -73.579185, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h825 = RoomCoordinate(
        45.497085, -73.579116, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h823 = RoomCoordinate(
        45.497054, -73.579047, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h821 = RoomCoordinate(
        45.497019, -73.578975, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h802_01 = RoomCoordinate(
        45.497220, -73.578667, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h806_01 = RoomCoordinate(
        45.497162, -73.578785, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h806_02 = RoomCoordinate(
        45.497175, -73.578814, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h806_03 = RoomCoordinate(
        45.497190, -73.578848, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_06 = RoomCoordinate(
        45.497304, -73.579231, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_02 = RoomCoordinate(
        45.497305, -73.579231, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_05 = RoomCoordinate(
        45.497305, -73.579232, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_01 = RoomCoordinate(
        45.497306, -73.579232, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_03 = RoomCoordinate(
        45.497307, -73.579232, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h832_04 = RoomCoordinate(
        45.497305, -73.579233, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h820_01 = RoomCoordinate(
        45.497070, -73.579076, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h820_02 = RoomCoordinate(
        45.497071, -73.579076, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h820_03 = RoomCoordinate(
        45.497070, -73.579077, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h820_04 = RoomCoordinate(
        45.497072, -73.579076, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h822 = RoomCoordinate(
        45.497127, -73.579190, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h886 = RoomCoordinate(
        45.497036, -73.579001, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h860_01 = RoomCoordinate(
        45.497360, -73.578732, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h860_03 = RoomCoordinate(
        45.497360, -73.578733, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h860_04 = RoomCoordinate(
        45.497360, -73.578734, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h860_05 = RoomCoordinate(
        45.497361, -73.578732, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h860_06 = RoomCoordinate(
        45.497362, -73.578732, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h862 = RoomCoordinate(
        45.497307, -73.578789, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h840 = RoomCoordinate(
        45.497270, -73.578822, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h838_01 = RoomCoordinate(
        45.497316, -73.579104, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h838 = RoomCoordinate(
        45.497384, -73.579157, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h881 = RoomCoordinate(
        45.497459, -73.579086, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h852 = RoomCoordinate(
        45.497507, -73.578887, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});

    RoomCoordinate h854 = RoomCoordinate(
        45.497485, -73.578837, '8', 'Hall', 'SGW',
        adjCoordinates: <Coordinate>{});
  
   h8_ll.adjCoordinates = {h8_stairs_ll, h8_ul};
    h8_lr.adjCoordinates = {h8_lm, h8_mr};
    h8_lm.adjCoordinates = {h8_stairs_ll, h8_lr, h8_escalator_down};
    h8_ul.adjCoordinates = {h8_stairs_ul, h8_ll};
    h8_um.adjCoordinates = {h8_stairs_ul, h8_stairs_ur, h8_escalator_up};
    h8_ur.adjCoordinates = {h8_stairs_ur, h8_mr};
    h8_mm.adjCoordinates = {h8_escalator_up, h8_lm, h8_escalator_down};
    h8_mr.adjCoordinates = {h8_stairs_lr, h8_lr, h8_ur};
    h8_stairs_ll.adjCoordinates = {h8_ll, h8_lm};
    h8_stairs_lr.adjCoordinates = {h8_mr, h8_escalator_up};
    h8_stairs_ul.adjCoordinates = {h8_um, h8_ul};
    h8_stairs_ur.adjCoordinates = {h8_ur, h8_um};
    h8_escalator_down.adjCoordinates = {h8_um, h8_mm};
    h8_escalator_up.adjCoordinates = {h8_mm, h8_elevator};
    h8_elevator.adjCoordinates = {h8_stairs_lr, h8_escalator_up};
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
        type: "ROOM", roomId: "965", adjCoordinates: {j9F1, j9F4});

    RoomCoordinate h921 = RoomCoordinate(
        45.497380, -73.578606, '9', 'Hall', 'SGW',
        type: "ROOM", roomId: "921", adjCoordinates: {j9F20, j9F23});

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
