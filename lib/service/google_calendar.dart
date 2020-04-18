import 'dart:async';
import 'dart:convert' show json;
import 'google_signin.dart';
import "package:http/http.dart" as http;

class CalendarService {
  Future<Map<String, dynamic>> getEvents() async {
    Map<String, String> auth = await GoogleLogIn.instance.getCurrentUserAuth();

    http.Response response = await http.get(
      'https://www.googleapis.com/calendar/v3/calendars/primary/events',
      headers: auth,
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 403) {
        auth = await GoogleLogIn.instance.getCurrentUserAuth();
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
