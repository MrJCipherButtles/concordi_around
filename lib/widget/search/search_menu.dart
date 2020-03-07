import 'package:concordi_around/model/coordinate.dart';
import 'package:flutter/widgets.dart';

import 'building_manager.dart';

class SearchMenuListOption extends StatelessWidget {
  final Function(Coordinate) coordinate;

  SearchMenuListOption({this.coordinate});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      DisplayBuildingListManager(
        coordinate: (Coordinate coordinate) => {this.coordinate(coordinate)},
      ),
    ]));
  }
}
