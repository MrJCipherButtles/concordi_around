import 'dart:async';
import '../widget/user/user_info.dart';
import 'package:flutter/material.dart';
import '../service/google_calendar.dart';
import '../service/google_signin.dart';
import 'package:flutter/widgets.dart';

class CalendarNotifier with ChangeNotifier {
  var calendarService = CalendarService();
  var name = UserInfoWidgets.name;
  var email = UserInfoWidgets.email;
  Widget avatar = UserInfoWidgets.avatar;

  Map<DateTime, List> events = {};
  Map<DateTime, List> detailedEvents = {};

  getCurrentName() async {
    var user = await GoogleLogIn.instance.silentSignIn();

    if (user != null) {
      name = UserInfoWidgets.setName(await user.displayName);
      notifyListeners();
    }
  }

  getCurrentEmail() async {
    var user = await GoogleLogIn.instance.silentSignIn();

    if (user != null) {
      email = UserInfoWidgets.setEmail(await user.email);
      notifyListeners();
    }
  }

  getCurrentAvatar() async {
    var user = await GoogleLogIn.instance.silentSignIn();

    if (user != null) {
      avatar = UserInfoWidgets.setAvatar(await user.photoUrl);
      notifyListeners();
    }
  }

  Future<void> setEvents() async {
    events = {};
    final Map<String, dynamic> data = await calendarService.getEvents();

    var items = data['items'];

    DateTime date;

    items.forEach((item) => {
          if (item['start']['dateTime'] != null)
            {
              date = DateTime.parse(item['start']['dateTime']).toLocal(),
              if (events[DateTime(date.year, date.month, date.day)] == null)
                {
                  events[DateTime(date.year, date.month, date.day)] = [
                    item['summary']
                  ]
                }
              else
                {
                  events[DateTime(date.year, date.month, date.day)] =
                      events[DateTime(date.year, date.month, date.day)] +
                          [item['summary']]
                }
            }
        });

    notifyListeners();
    setDetailedEvents();
  }

  Future<void> setDetailedEvents() async {
    detailedEvents = {};
    final Map<String, dynamic> data = await calendarService.getEvents();

    var items = data['items'];

    items.forEach((item) => {
          if (item['start']['dateTime'] != null)
            {
              if (detailedEvents[
                      DateTime.parse(item['start']['dateTime']).toLocal()] ==
                  null)
                {
                  detailedEvents[DateTime.parse(item['start']['dateTime'])
                      .toLocal()] = [item['location']]
                }
              else
                {
                  detailedEvents[DateTime.parse(item['start']['dateTime'])
                      .toLocal()] = detailedEvents[
                          DateTime.parse(item['start']['dateTime']).toLocal()] +
                      [item['location']]
                }
            }
        });
  }

  String getNextClass() {
    var now = DateTime.now().toLocal();
    var min = 999999;
    String nextCourse = "";

    detailedEvents.forEach((key, value) => {
          if (key.difference(now).inMinutes >= 0 &&
              key.difference(now).inMinutes <= min)
            {min = key.difference(now).inMinutes, nextCourse = value[0]}
        });

    return nextCourse;
  }
}
