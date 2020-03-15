import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShuttleTimes {
  List<TimeOfDay> sgwWeekdays = List(36);
  List<TimeOfDay> loyWeekdays = List(37);
  List<TimeOfDay> sgwFriday = List(27);
  List<TimeOfDay> loyFriday = List(27);
  List<TimeOfDay> sgwNextDepartures = List();
  List<TimeOfDay> loyNextDepartures = List();
  int weekday = DateTime.now().weekday;
  TimeOfDay nextShuttle;
  TimeOfDay now = TimeOfDay.now();

  TimeOfDay findNextShuttleSGW() {
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
    sgwFriday[13] = TimeOfDay(hour: 13, minute: 45);
    sgwFriday[14] = TimeOfDay(hour: 14, minute: 05);
    sgwFriday[15] = TimeOfDay(hour: 14, minute: 40);
    sgwFriday[16] = TimeOfDay(hour: 14, minute: 55);
    sgwFriday[17] = TimeOfDay(hour: 15, minute: 15);
    sgwFriday[18] = TimeOfDay(hour: 15, minute: 50);
    sgwFriday[19] = TimeOfDay(hour: 16, minute: 05);
    sgwFriday[20] = TimeOfDay(hour: 16, minute: 25);
    sgwFriday[21] = TimeOfDay(hour: 17, minute: 15);
    sgwFriday[22] = TimeOfDay(hour: 17, minute: 30);
    sgwFriday[23] = TimeOfDay(hour: 18, minute: 05);
    sgwFriday[24] = TimeOfDay(hour: 18, minute: 40);
    sgwFriday[25] = TimeOfDay(hour: 19, minute: 15);
    sgwFriday[26] = TimeOfDay(hour: 19, minute: 50);

    return findNextShuttleTime(sgwWeekdays, sgwFriday);
  }

  TimeOfDay findNextShuttleLOYOLA() {
    loyWeekdays[0] = TimeOfDay(hour: 7, minute: 30);
    loyWeekdays[1] = TimeOfDay(hour: 7, minute: 40);
    loyWeekdays[2] = TimeOfDay(hour: 7, minute: 55);
    loyWeekdays[3] = TimeOfDay(hour: 8, minute: 20);
    loyWeekdays[4] = TimeOfDay(hour: 8, minute: 35);
    loyWeekdays[5] = TimeOfDay(hour: 8, minute: 55);
    loyWeekdays[6] = TimeOfDay(hour: 9, minute: 10);
    loyWeekdays[7] = TimeOfDay(hour: 9, minute: 30);
    loyWeekdays[8] = TimeOfDay(hour: 9, minute: 45);
    loyWeekdays[9] = TimeOfDay(hour: 10, minute: 20);
    loyWeekdays[10] = TimeOfDay(hour: 10, minute: 35);
    loyWeekdays[11] = TimeOfDay(hour: 10, minute: 55);
    loyWeekdays[12] = TimeOfDay(hour: 11, minute: 10);
    loyWeekdays[13] = TimeOfDay(hour: 11, minute: 30);
    loyWeekdays[14] = TimeOfDay(hour: 12, minute: 00);
    loyWeekdays[15] = TimeOfDay(hour: 12, minute: 30);
    loyWeekdays[16] = TimeOfDay(hour: 13, minute: 00);
    loyWeekdays[17] = TimeOfDay(hour: 13, minute: 30);
    loyWeekdays[18] = TimeOfDay(hour: 14, minute: 00);
    loyWeekdays[19] = TimeOfDay(hour: 14, minute: 30);
    loyWeekdays[20] = TimeOfDay(hour: 15, minute: 00);
    loyWeekdays[21] = TimeOfDay(hour: 15, minute: 30);
    loyWeekdays[22] = TimeOfDay(hour: 16, minute: 00);
    loyWeekdays[23] = TimeOfDay(hour: 16, minute: 30);
    loyWeekdays[24] = TimeOfDay(hour: 17, minute: 00);
    loyWeekdays[25] = TimeOfDay(hour: 17, minute: 30);
    loyWeekdays[26] = TimeOfDay(hour: 18, minute: 00);
    loyWeekdays[27] = TimeOfDay(hour: 18, minute: 30);
    loyWeekdays[28] = TimeOfDay(hour: 19, minute: 00);
    loyWeekdays[29] = TimeOfDay(hour: 19, minute: 30);
    loyWeekdays[30] = TimeOfDay(hour: 20, minute: 00);
    loyWeekdays[31] = TimeOfDay(hour: 20, minute: 30);
    loyWeekdays[32] = TimeOfDay(hour: 21, minute: 00);
    loyWeekdays[33] = TimeOfDay(hour: 21, minute: 30);
    loyWeekdays[34] = TimeOfDay(hour: 22, minute: 00);
    loyWeekdays[35] = TimeOfDay(hour: 22, minute: 30);
    loyWeekdays[36] = TimeOfDay(hour: 23, minute: 00);

    loyFriday[0] = TimeOfDay(hour: 7, minute: 40);
    loyFriday[1] = TimeOfDay(hour: 8, minute: 15);
    loyFriday[2] = TimeOfDay(hour: 8, minute: 55);
    loyFriday[3] = TimeOfDay(hour: 9, minute: 10);
    loyFriday[4] = TimeOfDay(hour: 9, minute: 30);
    loyFriday[5] = TimeOfDay(hour: 10, minute: 20);
    loyFriday[6] = TimeOfDay(hour: 10, minute: 35);
    loyFriday[7] = TimeOfDay(hour: 11, minute: 10);
    loyFriday[8] = TimeOfDay(hour: 11, minute: 30);
    loyFriday[9] = TimeOfDay(hour: 11, minute: 45);
    loyFriday[10] = TimeOfDay(hour: 12, minute: 20);
    loyFriday[11] = TimeOfDay(hour: 12, minute: 40);
    loyFriday[12] = TimeOfDay(hour: 12, minute: 55);
    loyFriday[13] = TimeOfDay(hour: 13, minute: 30);
    loyFriday[14] = TimeOfDay(hour: 14, minute: 05);
    loyFriday[15] = TimeOfDay(hour: 14, minute: 20);
    loyFriday[16] = TimeOfDay(hour: 14, minute: 40);
    loyFriday[17] = TimeOfDay(hour: 15, minute: 15);
    loyFriday[18] = TimeOfDay(hour: 15, minute: 30);
    loyFriday[19] = TimeOfDay(hour: 15, minute: 50);
    loyFriday[20] = TimeOfDay(hour: 16, minute: 25);
    loyFriday[21] = TimeOfDay(hour: 16, minute: 40);
    loyFriday[22] = TimeOfDay(hour: 17, minute: 00);
    loyFriday[23] = TimeOfDay(hour: 18, minute: 05);
    loyFriday[24] = TimeOfDay(hour: 18, minute: 40);
    loyFriday[25] = TimeOfDay(hour: 19, minute: 15);
    loyFriday[26] = TimeOfDay(hour: 19, minute: 50);

    return findNextShuttleTime(loyWeekdays, loyFriday);
  }

  //Depending on the day of the week, and the time of the days, returns the time for the soonest shuttle available
  TimeOfDay findNextShuttleTime(List weekdays, List fridays) {
    if (weekday == 6 || weekday == 7) {
      return (weekdays[0]);
    } else {
      TimeOfDay nextShuttleTime(List shuttles) {
        var i = 0;
        while (i < shuttles.length) {
          nextShuttle = shuttles[i];
          if (nextShuttle.hour == now.hour &&
              nextShuttle.minute >= now.minute) {
            nextShuttle = shuttles[i];
            break;
          } else if (nextShuttle.hour > now.hour) {
            nextShuttle = shuttles[i];
            break;
          }
          i++;
        }
        return nextShuttle;
      }

      if (weekday == 1 || weekday == 2 || weekday == 3) {
        if (now.hour >= 23) {
          return weekdays[0];
        } else {
          return nextShuttleTime(weekdays);
        }
      } else if (weekday == 4) {
        if (now.hour < 23) {
          return nextShuttleTime(weekdays);
        } else {
          return fridays[0];
        }
      } else if (weekday == 5 &&
          ((now.hour >= 19 && now.minute >= 50) || now.hour >= 20)) {
        return weekdays[0];
      } else {
        return nextShuttleTime(fridays);
      }
    }
  }

  //Based on the current time of the day, returns all future departures remaining
  void nextShuttleDepartures(List shuttles, List fridays, List weekdays,
      List nextDepartures, TimeOfDay nextShuttleTime) {
    var i = 0;
    while (i < shuttles.length) {
      if ((shuttles[i].hour == nextShuttleTime.hour &&
              shuttles[i].minute >= nextShuttleTime.minute) ||
          (shuttles[i].hour > nextShuttleTime.hour)) {
        if (weekday == 5 &&
                ((now.hour <= 19 && now.minute <= 50) || now.hour < 20) ||
            (weekday == 4 && now.hour >= 23)) {
          nextDepartures.add(fridays[i]);
        } else {
          nextDepartures.add(weekdays[i]);
        }
      }
      i++;
    }
  }

  String formatTimeOfDay(TimeOfDay today) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, today.hour, today.minute);
    final format = DateFormat.jm();

    return format.format(dt);
  }

  String listViewText() {
    if (weekday == 6 ||
        weekday == 7 ||
        (weekday == 5 &&
            ((now.hour >= 19 && now.minute >= 50) || now.hour >= 20))) {
      return "Scheduled for Monday · ";
    } else {
      return "Scheduled · ";
    }
  }
}
