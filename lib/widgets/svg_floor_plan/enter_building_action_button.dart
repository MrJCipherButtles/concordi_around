import 'package:concordi_around/provider/map_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterBuildingButton extends StatelessWidget {
  final VoidCallback isPressed;
  EnterBuildingButton({this.isPressed});

  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: mapNotifier.showEnterBuilding,
      child: FloatingActionButton(
          onPressed: () => isPressed(),
          backgroundColor: Color.fromRGBO(147, 0, 47, 1),
          foregroundColor: Colors.white,
          child: Icon(Icons.arrow_upward)),
    );
  }
}
