import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShuttleTimes {
  String formatTimeOfDay(TimeOfDay today) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, today.hour, today.minute);
    final format = DateFormat.jm();

    return format.format(dt);
  }

  String findNextShuttle() {
    int weekday = DateTime.now().weekday;
    TimeOfDay nextShuttle;
    TimeOfDay now = TimeOfDay.now();
    List<TimeOfDay> sgwWeekdays = new List(36);
    List<TimeOfDay> sgwFriday = new List(26);

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

    sgwFriday[0] = TimeOfDay(hour: 7, minute: 45);
    sgwFriday[1] = TimeOfDay(hour: 8, minute: 20);
    sgwFriday[2] = TimeOfDay(hour: 8, minute: 55);
    sgwFriday[3] = TimeOfDay(hour: 9, minute: 30);
    sgwFriday[4] = TimeOfDay(hour: 9, minute: 45);
    sgwFriday[5] = TimeOfDay(hour: 10, minute: 05);
    sgwFriday[6] = TimeOfDay(hour: 10, minute: 55);
    sgwFriday[7] = TimeOfDay(hour: 11, minute: 10);
    sgwFriday[8] = TimeOfDay(hour: 11, minute: 45);
    sgwFriday[9] = TimeOfDay(hour: 12, minute: 05);
    sgwFriday[10] = TimeOfDay(hour: 12, minute: 20);
    sgwFriday[11] = TimeOfDay(hour: 12, minute: 55);
    sgwFriday[12] = TimeOfDay(hour: 13, minute: 30);
    sgwFriday[13] = TimeOfDay(hour: 14, minute: 05);
    sgwFriday[14] = TimeOfDay(hour: 14, minute: 40);
    sgwFriday[15] = TimeOfDay(hour: 14, minute: 55);
    sgwFriday[16] = TimeOfDay(hour: 15, minute: 15);
    sgwFriday[17] = TimeOfDay(hour: 15, minute: 50);
    sgwFriday[18] = TimeOfDay(hour: 16, minute: 05);
    sgwFriday[19] = TimeOfDay(hour: 16, minute: 25);
    sgwFriday[20] = TimeOfDay(hour: 17, minute: 15);
    sgwFriday[21] = TimeOfDay(hour: 17, minute: 30);
    sgwFriday[22] = TimeOfDay(hour: 18, minute: 05);
    sgwFriday[23] = TimeOfDay(hour: 18, minute: 40);
    sgwFriday[24] = TimeOfDay(hour: 19, minute: 15);
    sgwFriday[25] = TimeOfDay(hour: 19, minute: 50);

    if (weekday == 6 || weekday == 7) {
      return "Next Shuttle: Monday " + formatTimeOfDay(sgwWeekdays[0]);  
    } else {
      TimeOfDay nextShuttleTime(List campus) {
        var i = 0;
        while (i < campus.length - 1) {
          nextShuttle = campus[i];

          if (nextShuttle.hour == now.hour &&
              nextShuttle.minute >= now.minute) {
            nextShuttle = campus[i];
            break;
          } else if (nextShuttle.hour > now.hour) {
            nextShuttle = campus[i];
            break;
          }
          i++;
        }
        return nextShuttle;
      }

      if (weekday == 1 || weekday == 2 || weekday == 3 || weekday == 4) {
        if (now.hour >= 23) {
          return "Next Shuttle: " + formatTimeOfDay(sgwWeekdays[0]);
        } else {
          return "Next Shuttle: " +
              formatTimeOfDay(nextShuttleTime(sgwWeekdays));
        }
      } else if (weekday == 5 && (now.hour >= 19 && now.minute >= 50)) {
        return "Next Shuttle: Monday " + formatTimeOfDay(sgwWeekdays[0]);
      } else {
        return "Next Shuttle: " + formatTimeOfDay(nextShuttleTime(sgwFriday));
      }
    }
  }
}
