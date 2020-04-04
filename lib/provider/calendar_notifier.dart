import 'dart:async';
import 'package:concordi_around/service/google_calendar.dart';
import 'package:flutter/widgets.dart';

class CalendarNotifier with ChangeNotifier {
  var calendarService = new CalendarService();
  Map<DateTime, List> events = {};

  CalendarNotifier() {
    setEvents();
  }

  Future<void> setEvents() async {
    final Map<String, dynamic> data = await calendarService.getEvents();

    var items = data['items'];
    print(items);
    items.forEach((item) => {
          if (item['start']['dateTime'] != null)
            {
              if (events[DateTime.parse(item['start']['dateTime'])] == null)
                {
                  events[DateTime.parse(item['start']['dateTime'])] = [
                    item['summary']
                  ]
                }
              else
                {
                  events[DateTime.parse(item['start']['dateTime'])] =
                      events[DateTime.parse(item['start']['dateTime'])] +
                          [item['summary']]
                }
            }
        });
    notifyListeners();
  }
}