import 'package:flutter/material.dart';

import './buildingManager.dart';

class SearchMenuListOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Container(child: Expanded(
        flex: 2,
        child: Row(
          children: <Widget>[
            BuildingManager(),
          ]),
      ));
  }
}
