import 'package:flutter/widgets.dart';

class MapNotifier with ChangeNotifier {
  bool showFloorSelector = false;

  void setFloorSelectorVisibility(bool visibility) {
    showFloorSelector = visibility;
    notifyListeners();
  }
}