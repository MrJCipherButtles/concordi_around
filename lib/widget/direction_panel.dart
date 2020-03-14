import 'package:concordi_around/provider/direction_notifier.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DirectionPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DirectionPanelState();
  }
}

class _DirectionPanelState extends State<DirectionPanel> {
  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(BORDER_RADIUS),
    topRight: Radius.circular(BORDER_RADIUS),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectionNotifier>(
        builder: (context, directionNotifier, child) {
      return Visibility(
          visible: directionNotifier.showDirectionPanel,
          child: SlidingUpPanel(
            minHeight: 80,
            panelBuilder: (ScrollController sc) => _scrollingList(sc),
            collapsed: Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: radius),
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 16),
                    getModeIcon(directionNotifier.mode),
                    SizedBox(width: 16),
                    Text(
                      "Your estimated time is 10 min",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 16),
                    RaisedButton(
                      child: Text("Done"),
                      textColor: Colors.white,
                      color: COLOR_CONCORDIA,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.circular(BORDER_RADIUS)),
                      onPressed: () {
                        directionNotifier.setShowDirectionPanel(false);
                      },
                    )
                  ],
                ),
              ),
            ),
            borderRadius: radius,
          ));
    });
  }

  Widget _scrollingList(ScrollController sc){
  return ListView.builder(
    controller: sc,
    itemCount: 20, // TODO Changes to directions.length
    itemBuilder: (BuildContext context, int i){
      return Padding(
        padding: const EdgeInsets.only(left: 16),
              child: Row(
          children: <Widget>[
            Icon(Icons.directions),
            Container(
              padding: const EdgeInsets.all(20),
              child: Text("$i"),
            ),
          ],
        ),
      );
    },
  );
}

  Icon getModeIcon(DrivingMode mode) {
    if(mode == DrivingMode.Car)
    return Icon(Icons.directions_car);
    else if (mode == DrivingMode.Bus)
    return Icon(Icons.directions_bus);
    else if (mode == DrivingMode.Bike)
    return Icon(Icons.directions_bike);
    return Icon(Icons.directions_walk);
  }
}
