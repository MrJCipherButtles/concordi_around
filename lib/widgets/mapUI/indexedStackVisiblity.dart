import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:concordi_around/globals' as globals;

class IndexedStackVisibility extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _IndexedStackVisibilityState();
  }
}

class _IndexedStackVisibilityState extends State<IndexedStackVisibility> {

  bool showFloorplan = false;
  int showFloor = 0;

  @override
  Widget build(BuildContext context) {
    return 
    Visibility(
      child: IndexedStack(
        index: showFloor,
        children: <Widget>[
          SvgPicture.asset("assets/floorplans/Hall-8.svg"),
          SvgPicture.asset("assets/floorplans/Hall-9.svg"),
        ],
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: globals.showMap,
    );
  }
}