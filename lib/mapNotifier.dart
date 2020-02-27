import 'package:flutter/widgets.dart';

class MapNotifier with ChangeNotifier {
  bool showFloorSelector = false;
  bool animateFloorPlanFromSearch = false;
  int selectedFloorPlan = 8; 

  void setFloorSelectorVisibility(bool visibility) {
    showFloorSelector = visibility;
    notifyListeners();
  }

  void setSelectedFloor(int selectedFloor) {
    selectedFloorPlan = selectedFloor;
    notifyListeners();
  }
}