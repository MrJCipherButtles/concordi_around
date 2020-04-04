import '../provider/direction_notifier.dart';
import '../service/map_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DirectionPanel extends StatefulWidget {
  final Function(bool) removeDirectionPolyline;

  DirectionPanel({this.removeDirectionPolyline});

  @override
  State<StatefulWidget> createState() {
    return DirectionPanelState();
  }
}

class DirectionPanelState extends State<DirectionPanel> {
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
            panelBuilder: (ScrollController sc) =>
                _scrollingList(sc, directionNotifier.getStepDirections()),
            collapsed: Container(
              decoration:
                  BoxDecoration(color: Colors.white, borderRadius: radius),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.maximize),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getModeIcon(directionNotifier.mode),
                        Flexible(
                          child: Text(
                            "${directionNotifier.getDuration()} (${directionNotifier.getDistance()})",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                        IconButton(
                            key: Key('Direction Panel close'),
                            icon: Icon(Icons.close),
                            onPressed: () => {
                                  directionNotifier
                                      .setShowDirectionPanel(false),
                                  directionNotifier.clearAll(),
                                  widget.removeDirectionPolyline(true)
                                })
                      ],
                    ),
                  ],
                ),
              ),
            ),
            borderRadius: radius,
          ));
    });
  }

  Widget _scrollingList(ScrollController sc, List<String> directions) {
    return ListView.builder(
      controller: sc,
      itemCount: directions.length,
      itemBuilder: (BuildContext context, int i) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  isCustomIconRequired(directions[i])
                      ? getCustomDirectionIcon(directions[i])
                      : getDirectionIcon(directions[i]),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${i + 1}."),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(child: Text("${directions[i]}")),
                ],
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        );
      },
    );
  }

  bool isCustomIconRequired(String direction) {
    if (direction.toLowerCase().contains("left") ||
        direction.toLowerCase().contains("right") ||
        direction.toLowerCase().contains("head") ||
        direction.toLowerCase().contains("continue")) return true;
    return false;
  }

  ImageIcon getCustomDirectionIcon(String direction) {
    if (direction.toLowerCase().contains("slight left"))
      return ImageIcon(
        AssetImage("assets/direction_icon/slight_left.png"),
        color: Colors.black,
      );
    else if (direction.toLowerCase().contains("slight right"))
      return ImageIcon(
        AssetImage("assets/direction_icon/slight_right.png"),
        color: Colors.black,
      );
    else if (direction.toLowerCase().contains("turn left"))
      return ImageIcon(
        AssetImage("assets/direction_icon/turn_left.png"),
        color: Colors.black,
      );
    else if (direction.toLowerCase().contains("turn right"))
      return ImageIcon(
        AssetImage("assets/direction_icon/turn_right.png"),
        color: Colors.black,
      );
    return ImageIcon(
      AssetImage("assets/direction_icon/straight.png"),
      color: Colors.black,
    );
  }

  Icon getDirectionIcon(String direction) {
    if (direction.toLowerCase().contains("walk"))
      return Icon(Icons.directions_walk);
    else if (direction.toLowerCase().contains("bus"))
      return Icon(Icons.directions_bus);
    else if (direction.toLowerCase().contains("shuttle"))
      return Icon(Icons.airport_shuttle);
    else if (direction.toLowerCase().contains("subway"))
      return Icon(Icons.directions_subway);
    return Icon(Icons.info);
  }

  Icon getModeIcon(DrivingMode mode) {
    if (mode == DrivingMode.driving)
      return Icon(Icons.directions_car);
    else if (mode == DrivingMode.transit)
      return Icon(Icons.directions_transit);
    else if (mode == DrivingMode.bicycling)
      return Icon(Icons.directions_bike);
    else if (mode == DrivingMode.shuttle) return Icon(Icons.airport_shuttle);
    return Icon(Icons.directions_walk);
  }
}
