import 'package:flutter/cupertino.dart';

class DirectionNotifier extends ChangeNotifier {
  bool showDirectionPanel = false;

  void setShowDirectionPanel(bool visiblity) {
    showDirectionPanel = visiblity;
    notifyListeners();
  }
}
