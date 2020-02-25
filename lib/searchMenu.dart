import 'package:flutter/material.dart';

import './buildingManager.dart';

class SearchMenuListOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),)
      ]),
      SizedBox(height: 5),
      DisplayBuildingListManager(),
        ]));
  }
}