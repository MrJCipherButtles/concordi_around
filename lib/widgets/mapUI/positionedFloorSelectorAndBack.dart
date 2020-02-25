import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/globals' as globals;

class PositionedFloorSelectorAndBack extends StatefulWidget {
  Function(int) floorIndex;



  @override
  State<StatefulWidget> createState() {
    return _PositionedFloorSelectorAndBackState();
  }
}

class _PositionedFloorSelectorAndBackState
    extends State<PositionedFloorSelectorAndBack> {

  List<bool> selectedFloor = [false, true]; // 8th floor selected

  Widget build(BuildContext context) {
        return Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: globals.showMap,
      child: Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: RotatedBox(
              quarterTurns: 1,
              child: ToggleButtons(
                selectedColor: Colors.white,
                color: Colors.black,
                fillColor: Colors.grey,
                borderColor: Colors.grey,
                children: <Widget>[
                  RotatedBox(quarterTurns: 3, child: Text("9")),
                  RotatedBox(quarterTurns: 3, child: Text("8")),
                ],
                isSelected: selectedFloor,
                onPressed: (int index) {
                  setState(() {
                    selectedFloor[0] = !selectedFloor[0];
                    selectedFloor[1] = !selectedFloor[1];
                  });
                },
              ),
            ),
          ),
          Container(
              child: FloatingActionButton(
            child: Icon(Icons.arrow_back),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            onPressed: () => {
              setState(() {
                    globals.showMap = false;
                  })
            },
          ))
        ],
      ),
    ));
  }
}
