
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IndexedStackVisibility extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  IndexedStack(
      index: 1,
      children: <Widget>[
    Visibility(
            child: SvgPicture.asset("assets/floorplans/Hall-8.svg"),
            maintainSize: true, 
            maintainAnimation: true,
            maintainState: true,
            visible: true, 
          )
  ],
    );
  }
}