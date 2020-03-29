import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import "package:http/http.dart" as http;
import 'dart:convert' show json;

class MyCalendar extends StatefulWidget {
  MyCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  bool _isLoggedIn = false;
  dynamic events;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/calendar.readonly',
    ],
  );

  _login() async {
    await _googleSignIn.signInSilently();
    if (_googleSignIn.currentUser != null) {
      events = await getEvents();
      setState(() {
        _isLoggedIn = true;
      });
    } else {
      try {
        await _googleSignIn.signIn();
        events = await getEvents();
        setState(() {
          _isLoggedIn = true;
        });
      } catch (err) {
        print(err);
      }
    }
  }

  getEvents() async {
    http.Response response = await http.get(
      'https://www.googleapis.com/calendar/v3/calendars/primary/events',
      headers: await _googleSignIn.currentUser.authHeaders,
    );

    print(response.body);
    if (response.statusCode != 200) {
      print(
          'Calendar Events API ${response.statusCode} response: ${response.body}');
      return null;
    }

    Map<String, dynamic> data = json.decode(response.body);

    var items = data['items'];
    print(items);
    items.forEach((item) => {
          if (item['start']['dateTime'] != null)
            {
              if (_events[DateTime.parse(item['start']['dateTime'])] == null)
                {
                  _events[DateTime.parse(item['start']['dateTime'])] = [
                    item['summary']
                  ]
                }
              else
                {
                  _events[DateTime.parse(item['start']['dateTime'])] =
                      _events[DateTime.parse(item['start']['dateTime'])] +
                          [item['summary']]
                }
            }
        });
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {};

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
    _login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.dehaze, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.title),
          backgroundColor: constant.COLOR_CONCORDIA),
      body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        _buildTableCalendar(),
        const SizedBox(height: 8.0),
        Expanded(child: _buildEventList()),
      ]),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: constant.COLOR_CONCORDIA,
        todayColor: Color.fromRGBO(140, 139, 137, 1),
        markersColor: Colors.grey[300],
        weekendStyle: TextStyle(color: constant.COLOR_CONCORDIA),
        markersPositionBottom: 9,
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: constant.COLOR_CONCORDIA,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: constant.COLOR_CONCORDIA),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  title: Text(event.toString()),
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
