import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndexedStackVisibility extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: IndexedStack(
        index: 0,
        children: <Widget>[
          SvgPicture.asset("assets/floorplans/Hall-8.svg"),
          SvgPicture.asset("assets/floorplans/Hall-9.svg"),
        ],
      ),
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: false,
    );
  }
}
