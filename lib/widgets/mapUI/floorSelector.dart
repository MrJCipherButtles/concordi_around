import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloorSelector extends StatefulWidget {

  final bool showFloorSelector;
  final Function(int) selectedFloor;

  FloorSelector({this.showFloorSelector,this.selectedFloor});

  @override
  State<StatefulWidget> createState([bool showFloorSelector]) {
    return _FloorSelectorState(showFloorSelector);
  }
}

class _FloorSelectorState
    extends State<FloorSelector> { 
       
  bool showFloorSelector;
  List<bool> selectedFloor = [false, true]; // 8th floor selected

  _FloorSelectorState(this.showFloorSelector);

  Widget build(BuildContext context) {
        return Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: widget.showFloorSelector,
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
                    widget.selectedFloor(index);
                    setState(() {
                      selectedFloor = [false, false];
                      selectedFloor[index] = true;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
