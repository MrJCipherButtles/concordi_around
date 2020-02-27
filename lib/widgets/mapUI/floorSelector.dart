import 'package:concordi_around/mapNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorSelector extends StatefulWidget {

  final Function(int) selectedFloor;
  FloorSelector({this.selectedFloor});

  @override
  State<StatefulWidget> createState() {
    return _FloorSelectorState();
  }
}

class _FloorSelectorState
    extends State<FloorSelector> { 
       
  List<bool> selectedFloor = [false, true]; // 8th floor selected

  Widget build(BuildContext context) {
      MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

        return Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: mapNotifier.showFloorSelector,
      child: Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Color.fromRGBO(147, 0, 47, 1),
              foregroundColor: Colors.white,
              child: Icon(Icons.arrow_upward),
              ),
              SizedBox(height: 16),
            Container(
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
          ],
        ),
      ));
  }
}
