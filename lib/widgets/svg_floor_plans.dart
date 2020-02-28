import 'package:concordi_around/provider/mapNotifier.dart';
import 'package:concordi_around/widgets/custom/custom_fade_indexed_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SVGFloorPlans extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FloorplanIndexedStackVisibility();
  }
}

class _FloorplanIndexedStackVisibility
    extends State<SVGFloorPlans> {

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);
    
    return Visibility(
      child: AnimatedOpacity(
          opacity: mapNotifier.showFloorPlan ? 1.0 : 0.0,
          curve: Curves.easeInToLinear,
          duration: Duration(milliseconds: 1500),
          child: FadeIndexedStack(
            index: mapNotifier.selectedFloorPlan == 8 ? 0 : 1,
            children: <Widget>[
              SvgPicture.asset("assets/floorplans/Hall-8.svg"),
              SvgPicture.asset("assets/floorplans/Hall-9.svg"),
            ],
          )),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: mapNotifier.showFloorPlan,
    );
  }
}
