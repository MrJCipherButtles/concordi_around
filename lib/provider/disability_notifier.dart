import 'package:flutter/widgets.dart';

class DisabilityNotifier with ChangeNotifier {
  bool isDisabilityEnabled = false;

  void setDisabilityEnabled(bool disability) {
    isDisabilityEnabled = disability;
    notifyListeners();
  }
}