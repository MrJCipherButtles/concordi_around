import 'package:concordi_around/provider/map_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorSelectorEnterBuilding extends StatefulWidget {
  final Function(int) selectedFloor;
  final VoidCallback enterBuildingPressed;

  FloorSelectorEnterBuilding({this.selectedFloor, this.enterBuildingPressed});

  @override
  State<StatefulWidget> createState() {
    return _FloorSelectorEnterBuildingState();
  }
}

class _FloorSelectorEnterBuildingState
    extends State<FloorSelectorEnterBuilding> {
  Widget build(BuildContext context) {

    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);
    List<bool> selectedFloor = [mapNotifier.selectedFloorPlan == 9,mapNotifier.selectedFloorPlan == 8]; // 9th floor selected

    return Consumer<MapNotifier>(
      builder: (context, mapNotifier, child) => Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: mapNotifier.showFloorPlan,
                  child: Container(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: ToggleButtons(
                          selectedColor: Colors.white,
                          color: Colors.black,
                          fillColor: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                          borderColor: Colors.grey,
                          children: <Widget>[
                            RotatedBox(quarterTurns: 3, child: Text("9")),
                            RotatedBox(quarterTurns: 3, child: Text("8")),
                          ],
                          isSelected: selectedFloor,
                          onPressed: (int index) {
                            widget.selectedFloor(index == 0 ? 9 : 8);
                            setState(() {
                              selectedFloor = [false, false];
                              selectedFloor[index] = true;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
