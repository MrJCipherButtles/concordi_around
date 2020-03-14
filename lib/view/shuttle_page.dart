import 'package:concordi_around/service/shuttle_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;

class ShuttlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int weekday = DateTime.now().weekday;
    ShuttleTimes shuttleTimes = new ShuttleTimes();
    shuttleTimes.findNextShuttle();
    shuttleTimes.findNextShuttleLOYOLA();
    TimeOfDay now = TimeOfDay.now();
    if (weekday == 5 && ((now.hour <= 19 && now.minute<=50) || now.hour <20)) {
      shuttleTimes.nextDepartures(shuttleTimes.sgwFriday);
      shuttleTimes.loyNextDepartures(shuttleTimes.loyFriday);
    } else {
      shuttleTimes.nextDepartures(shuttleTimes.sgwWeekdays);
      shuttleTimes.loyNextDepartures(shuttleTimes.loyWeekdays);
    }
    List<Widget> containers = [
      ListView.builder(
        itemCount: shuttleTimes.nextDepratures.length,
        itemBuilder: (context, index) {
          return Container(
              child: ListTile(
                  trailing: Text(
                      shuttleTimes
                          .formatTimeOfDay(shuttleTimes.nextDepratures[index]),
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
                      Text("Scheduled · "),
                      Icon(Icons.accessible, color: Colors.grey, size: 15)
                    ],
                  )));
        },
      ),
      ListView.builder(
        itemCount: shuttleTimes.loyNextDepratures.length,
        itemBuilder: (context, index) {
          return Container(
              child: ListTile(
                  trailing: Text(
                      shuttleTimes
                          .formatTimeOfDay(shuttleTimes.loyNextDepratures[index]),
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
                      Text("Scheduled · "),
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
              //title: new Text(shuttleTimes.formatTimeOfDay(shuttleTimes.findNextShuttleLOYOLA())),
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
