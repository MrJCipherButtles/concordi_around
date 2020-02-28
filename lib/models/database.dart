class Coordinate {
  String _title; //
  //Naming convention for titles:
  //for rooms: builing+room number, example: H801
  //for path: builing+floor number+ P + (LL for lower left corner, MR for middle right etc) ex: H8-P-LL
  //for escalators: builing+floor number + ESC-D for escalator going down, ESC-U for escalator going up
  //for elevators: builing+floor number + elev. ex: H8-Elev
  //** Elevators and Escalaros should be considered as path points  */
  //for washrooms: builing+floor numbe+ "Men"/"Women"/"allGender" defines which type of washroom it is + iterator if there are more than one wr. ex: H8-MEN1

  String _type; // am for amenity, rm for rooms, pth for path, bul for building
  double _longitude;
  double _latitude;
  int _floorId; // 1000 for building!, 0 for ground floor, 1 for first floor (not 01)
  String _buildingName; // will be the building code, H, EV, JMSB etc
  String _campusName; // sgw or loy

//Constructor
  Coordinate(String title, String type, double lat, double long, int floor,
      String building, String campus) {
    this._title = title;
    this._type = type;
    this._longitude = long;
    this._latitude = lat;
    this._floorId = floor;
    this._buildingName = building;
    this._campusName = campus;
  }

// Class Getters
  String getTitle() {
    return this._title;
  }

  String getType() {
    return this._type;
  }

  double getLongitude() {
    return this._longitude;
  }

  double getLatitude() {
    return this._latitude;
  }

  int getFloorId() {
    return this._floorId;
  }

  String getBuildingName() {
    return this._buildingName;
  }

  String getCampusName() {
    return this._campusName;
  }
}

//List of Coordinates
List<Coordinate> rooms = [
  //Rooms for H8:
  Coordinate("H806", "rm", 45.49715, -73.57878, 8, "Hall", "sgw"),
  Coordinate("H832", "rm", 45.49728, -73.57924, 8, "Hall", "sgw"),
  Coordinate("H860", "rm", 45.49744, -73.57875, 8, "Hall", "sgw"),

  //Path points for H8:
  Coordinate("H8-P-LL", "pth", 45.49698, -73.57889, 8, "Hall", "sgw"),
  Coordinate("H8-P-LM", "pth", 45.49713, -73.57874, 8, "Hall", "sgw"),
  Coordinate("H8-P-MR", "pth", 45.49741, -73.57868, 8, "Hall", "sgw"),
  Coordinate("H8-P-UR", "pth", 45.49755, -73.57899, 8, "Hall", "sgw"),
  Coordinate("H8-P-UM", "pth", 45.49735, -73.57918, 8, "Hall", "sgw"),
  Coordinate("H8-P-UL", "pth", 45.49719, -73.57933, 8, "Hall", "sgw"),

  //Escalators for H8:
  Coordinate("H8-ESC-U", "pth", 45.49725, -73.57886, 8, "Hall", "sgw"),
  Coordinate("H8-ESC-D", "pth", 45.49733, -73.57902, 8, "Hall", "sgw"),

  //Elevator for H8  <should be considered for disabled persona>:
  Coordinate("H8-ELEV", "pth", 45.49731, 73.57875, 8, "Hall", "sgw"),

  //Washrooms for H8:
  Coordinate("H8-MEN1", "am", 45.4971, -73.57877, 8, "Hall", "sgw"),
  Coordinate("H8-WOMEN1", "am", 45.49723, -73.5786, 8, "Hall", "sgw"),
];
//Will be used towards showing recent places the user searched on the search suggestion list
final recentSearchedRooms = [
  Coordinate("H806", "rm", 45.49715, -73.57878, 8, "Hall", "sgw"),
  Coordinate("H832", "rm", 45.49728, -73.57924, 8, "Hall", "sgw"),
  Coordinate("H860", "rm", 45.49744, -73.57875, 8, "Hall", "sgw"),
];
