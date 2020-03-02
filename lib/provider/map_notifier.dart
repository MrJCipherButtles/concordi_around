import 'package:flutter/widgets.dart';

class MapNotifier with ChangeNotifier {
  bool showFloorPlan = false;
  bool showEnterBuilding = false;
  int selectedFloorPlan = 8;

  void setFloorPlanVisibility(bool visibility) {
    showFloorPlan = visibility;
    notifyListeners();
  }

  void setSelectedFloor(int selectedFloor) {
    selectedFloorPlan = selectedFloor;
    notifyListeners();
  }

  void setEnterBuildingVisibility(bool visibility) {
    showEnterBuilding = visibility;
    notifyListeners();
  }
}
