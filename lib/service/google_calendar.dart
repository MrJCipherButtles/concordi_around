import 'dart:async';
import 'dart:convert' show json;

import 'package:concordi_around/service/google_signin.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CalendarService{
   Future<Map<String, dynamic>> getEvents() async {

    var googleLogIn = GoogleLogIn.instance;
    GoogleSignInAccount ac = await googleLogIn.getCurrentUser();
    final http.Response response = await http.get(
      'https://www.googleapis.com/calendar/v3/calendars/primary/events',
      headers: await ac.authHeaders,
    );


    print(response.body);
    if (response.statusCode != 200) {
      print('Calendar Events API ${response.statusCode} response: ${response.body}');
      return null;
    }

    Map<String, dynamic> data = json.decode(response.body);
    return data;

  }

}