import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:concordi_around/globals' as globals;

class FloorplanIndexedStackVisibility extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FloorplanIndexedStackVisibility();
  }
}

class _FloorplanIndexedStackVisibility
    extends State<FloorplanIndexedStackVisibility> {

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: AnimatedOpacity(
          opacity: globals.showMap ? 1.0 : 0.0,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 1500),
          child: IndexedStack(
            index: 0,
            children: <Widget>[
              SvgPicture.asset("assets/floorplans/Hall-8.svg"),
              SvgPicture.asset("assets/floorplans/Hall-9.svg"),
            ],
          )),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: globals.showMap,
    );
  }
}
