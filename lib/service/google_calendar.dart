import 'dart:async';
import 'dart:convert' show json;

import 'package:concordi_around/service/google_signin.dart';
import "package:http/http.dart" as http;


class CalendarService {
  Future<Map<String, dynamic>> getEvents() async {
    Map<String, String> auth = await GoogleLogIn.instance.getCurrentUser();

    http.Response response = await http.get(
      'https://www.googleapis.com/calendar/v3/calendars/primary/events',
      headers: auth,
    );

    print(response.body);
    if (response.statusCode != 200) {
      print(
          'Calendar Events API ${response.statusCode} response: ${response.body}');
      if (response.statusCode == 403) {
        auth = await GoogleLogIn.instance.getCurrentUser();
        response = await http.get(
          'https://www.googleapis.com/calendar/v3/calendars/primary/events',
          headers: auth,
        );
      } else {
        return null;
      }
    }

    Map<String, dynamic> data = json.decode(response.body);
    return data;
  }
}
