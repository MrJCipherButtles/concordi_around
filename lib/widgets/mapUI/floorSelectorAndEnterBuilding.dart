import 'package:concordi_around/enterbuilding.dart';
import 'package:concordi_around/main.dart';
import 'package:concordi_around/mapNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorSelectorAndEnterBuilding extends StatefulWidget {

  final Function(int) selectedFloor;
  final VoidCallback enterBuildingPressed;

  FloorSelectorAndEnterBuilding({this.selectedFloor, this.enterBuildingPressed});

  

  @override
  State<StatefulWidget> createState() {
    return _FloorSelectorAndEnterBuildingState();
  }
}

class _FloorSelectorAndEnterBuildingState
    extends State<FloorSelectorAndEnterBuilding> { 
       
  List<bool> selectedFloor = [false, true]; // 8th floor selected

  Widget build(BuildContext context) {
      MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

        return Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
                child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EnterBuildingButton(isPressed: ()=> {widget.enterBuildingPressed()}),
              SizedBox(height: 16, width: 16),
              Visibility(
                maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: mapNotifier.showFloorPlan,
                            child: Container(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Container(
                      decoration:BoxDecoration( 
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
            ],
          ),
        );
  }
}
