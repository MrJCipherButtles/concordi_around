import 'package:concordi_around/widgets/search/building_manager.dart';
import 'package:flutter/material.dart';

class SearchMenuListOption extends StatelessWidget {

  final Function(String) name;

  SearchMenuListOption({this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      //flex: 2,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),),
        Expanded(flex: 1, child: BuildingManager(),)
      ]),
      SizedBox(height: 5),
      DisplayBuildingListManager(
        name: (String building) => {
          name(building)},
      ),
        ]));
  }
}
