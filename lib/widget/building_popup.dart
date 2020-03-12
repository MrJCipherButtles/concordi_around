import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:provider/provider.dart';

class BuildingPopup extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BuildingPopupState();
  }
}

class _BuildingPopupState extends State<BuildingPopup> {
  
  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);
    return Visibility(
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      visible: mapNotifier.showInfo,
      child:Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SlidingUpPanel(
              backdropEnabled: true,
              panel: Center(
                child: Text(
                  "Building Info"
                ),
              ),
              collapsed: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Pavillion Henry F. Hall Building",
                              style: TextStyle(fontSize: 22),
                            ),
                            ),
                          ),
                        Text(
                          "Boulevard de Maisonneuve O, Montreal, QC H3G 1M8",
                          style: TextStyle(fontSize: 12.5, color: Colors.grey),
                        ) 
                      ],
                    ),
                  ],
                ) 
                ),
          )
          ],
        )
      ));
  }
}