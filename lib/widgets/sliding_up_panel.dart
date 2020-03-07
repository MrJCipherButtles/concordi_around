import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/* class SlidingPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SlidingPanelState();
  }
}

class _SlidingPanelState extends State<SlidingPanel> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        panel:Center(
          child: Text("This is the sliding Widget")
        ),
        collapsed: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(147, 35, 57, 1),
          ),
          child: Center(
            child: Text(
              "This is the collapsed Widget",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
    );
  }
} */

class ShuttleTimes {

    String formatTimeOfDay(TimeOfDay today) {
    
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, today.hour, today.minute);
    final format = DateFormat.jm();  
    
    return format.format(dt);
    }

    String findNextShuttle() {

      List<TimeOfDay> sgwWeekdays = new List(36);
      sgwWeekdays[0] = TimeOfDay(hour: 7, minute: 45);
      sgwWeekdays[1] = TimeOfDay(hour: 8, minute: 05); 
      sgwWeekdays[2] = TimeOfDay(hour: 8, minute: 20); 
      sgwWeekdays[3] = TimeOfDay(hour: 8, minute: 35); 
      sgwWeekdays[4] = TimeOfDay(hour: 8, minute: 55); 
      sgwWeekdays[5] = TimeOfDay(hour: 9, minute: 10); 
      sgwWeekdays[6] = TimeOfDay(hour: 9, minute: 30); 
      sgwWeekdays[7] = TimeOfDay(hour: 10, minute: 45); 
      sgwWeekdays[8] = TimeOfDay(hour: 10, minute: 20); 
      sgwWeekdays[9] = TimeOfDay(hour: 10, minute: 55); 
      sgwWeekdays[10] = TimeOfDay(hour: 11, minute: 10); 
      sgwWeekdays[11] = TimeOfDay(hour: 11, minute: 45);
      sgwWeekdays[12] = TimeOfDay(hour: 12, minute: 20); 
      sgwWeekdays[13] = TimeOfDay(hour: 12, minute: 55); 
      sgwWeekdays[14] = TimeOfDay(hour: 13, minute: 30); 
      sgwWeekdays[15] = TimeOfDay(hour: 14, minute: 05); 
      sgwWeekdays[16] = TimeOfDay(hour: 14, minute: 40); 
      sgwWeekdays[17] = TimeOfDay(hour: 15, minute: 05); 
      sgwWeekdays[18] = TimeOfDay(hour: 15, minute: 45);
      sgwWeekdays[19] = TimeOfDay(hour: 16, minute: 05); 
      sgwWeekdays[20] = TimeOfDay(hour: 16, minute: 40); 
      sgwWeekdays[21] = TimeOfDay(hour: 17, minute: 05); 
      sgwWeekdays[22] = TimeOfDay(hour: 17, minute: 40); 
      sgwWeekdays[23] = TimeOfDay(hour: 18, minute: 05);
      sgwWeekdays[24] = TimeOfDay(hour: 18, minute: 40); 
      sgwWeekdays[25] = TimeOfDay(hour: 19, minute: 05); 
      sgwWeekdays[26] = TimeOfDay(hour: 19, minute: 40); 
      sgwWeekdays[27] = TimeOfDay(hour: 20, minute: 00); 
      sgwWeekdays[28] = TimeOfDay(hour: 20, minute: 10); 
      sgwWeekdays[29] = TimeOfDay(hour: 20, minute: 30); 
      sgwWeekdays[30] = TimeOfDay(hour: 21, minute: 00); 
      sgwWeekdays[31] = TimeOfDay(hour: 21, minute: 25); 
      sgwWeekdays[32] = TimeOfDay(hour: 21, minute: 45); 
      sgwWeekdays[33] = TimeOfDay(hour: 22, minute: 00); 
      sgwWeekdays[34] = TimeOfDay(hour: 22, minute: 30); 
      sgwWeekdays[35] = TimeOfDay(hour: 23, minute: 00); 

      TimeOfDay nextShuttle;
      TimeOfDay now = TimeOfDay.now(); 

      var i = 0;
      while (i < sgwWeekdays.length-1) {
      nextShuttle = sgwWeekdays[i];
      
      if(nextShuttle.hour == now.hour && nextShuttle.minute >= now.minute) {
        nextShuttle = sgwWeekdays[i];
        break; 
      }
      else if(nextShuttle.hour > now.hour) {
        nextShuttle = sgwWeekdays[i];
        break; 
      }
      i++;
     }
    
    if(now.hour >= 23) {
      return formatTimeOfDay(sgwWeekdays[0]);
    }
    else {
      return formatTimeOfDay(nextShuttle);
    }
  }
}