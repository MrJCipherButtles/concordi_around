import 'package:concordi_around/service/shuttle_schedule.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;

class ShuttlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int weekday = DateTime.now().weekday;
    ShuttleTimes shuttleTimes = new ShuttleTimes();
    shuttleTimes.findNextShuttleSGW();
    shuttleTimes.findNextShuttleLOYOLA();
    TimeOfDay now = TimeOfDay.now();
    if ((weekday == 5 &&
            ((now.hour <= 19 && now.minute <= 50) || now.hour < 20)) ||
        (weekday == 4 && now.hour >= 23)) {
      shuttleTimes.nextShuttleDepartures(
          shuttleTimes.sgwFriday,
          shuttleTimes.sgwFriday,
          shuttleTimes.sgwWeekdays,
          shuttleTimes.sgwNextDepartures,
          shuttleTimes.findNextShuttleSGW());
      shuttleTimes.nextShuttleDepartures(
          shuttleTimes.loyFriday,
          shuttleTimes.loyFriday,
          shuttleTimes.loyWeekdays,
          shuttleTimes.loyNextDepartures,
          shuttleTimes.findNextShuttleLOYOLA());
    } else {
      shuttleTimes.nextShuttleDepartures(
          shuttleTimes.sgwWeekdays,
          shuttleTimes.sgwFriday,
          shuttleTimes.sgwWeekdays,
          shuttleTimes.sgwNextDepartures,
          shuttleTimes.findNextShuttleSGW());
      shuttleTimes.nextShuttleDepartures(
          shuttleTimes.loyWeekdays,
          shuttleTimes.loyFriday,
          shuttleTimes.loyWeekdays,
          shuttleTimes.loyNextDepartures,
          shuttleTimes.findNextShuttleLOYOLA());
    }
    List<Widget> containers = [
      ListView.builder(
        itemCount: shuttleTimes.sgwNextDepartures.length,
        itemBuilder: (context, index) {
          return Container(
              child: ListTile(
                  trailing: Text(
                      shuttleTimes.formatTimeOfDay(
                          shuttleTimes.sgwNextDepartures[index]),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.airport_shuttle),
                      Icon(Icons.arrow_right),
                      Text(" Loyola Campus")
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Text(shuttleTimes.listViewText()),
                      Icon(Icons.accessible, color: Colors.grey, size: 15)
                    ],
                  )));
        },
      ),
      ListView.builder(
        itemCount: shuttleTimes.loyNextDepartures.length,
        itemBuilder: (context, index) {
          return Container(
              child: ListTile(
                  trailing: Text(
                      shuttleTimes.formatTimeOfDay(
                          shuttleTimes.loyNextDepartures[index]),
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  title: Row(
                    children: <Widget>[
                      Icon(Icons.airport_shuttle),
                      Icon(Icons.arrow_right),
                      Text(" SGW Campus")
                    ],
                  ),
                  subtitle: Row(
                    children: <Widget>[
                      Text(shuttleTimes.listViewText()),
                      Icon(Icons.accessible, color: Colors.grey, size: 15)
                    ],
                  )));
        },
      )
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
            title: new Text("Shuttle Bus Departures"),
            backgroundColor: constant.COLOR_CONCORDIA,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'SGW',
                ),
                Tab(
                  text: 'LOY',
                )
              ],
            )),
        body: TabBarView(
          children: containers,
        ),
      ),
    );
  }
}
