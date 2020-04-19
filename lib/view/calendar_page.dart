import '../service/map_constant.dart';
import '../data/building_singleton.dart';
import '../model/coordinate.dart';
import '../provider/calendar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../service/map_constant.dart' as constant;
import 'package:provider/provider.dart';

class MyCalendar extends StatefulWidget {
  final Function(Coordinate) destination;
  final String title;

  MyCalendar({Key key, this.title, this.destination}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  CalendarNotifier calendarNotifier;

  //global key is needed to obtain the right scaffold for the warning snackbar
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

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
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    calendarNotifier.setEvents();
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    calendarNotifier.setEvents();
    _events = calendarNotifier.events;
  }

  @override
  Widget build(BuildContext context) {
    List<RoomCoordinate> rooms = BuildingSingleton().getAllRooms();
    calendarNotifier = Provider.of<CalendarNotifier>(context);

    return Scaffold(
        key: _scaffoldKey,
      appBar: AppBar(
          title: Text(widget.title), backgroundColor: constant.COLOR_CONCORDIA),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),

      floatingActionButton: RaisedButton(

        child: Text("Go To My Next Class"),
        textColor: Colors.white,
        color: constant.COLOR_CONCORDIA,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(constant.BORDER_RADIUS)),
        onPressed: () {
          RoomCoordinate foundRoom;
          for (var room in rooms) {
            if (calendarNotifier
                .getNextClass()
                .toLowerCase()
                .contains(room.roomId.toLowerCase())) {
              foundRoom = room;
            }
          }
          if(foundRoom != null) {
            Navigator.pop(context);
            widget.destination(foundRoom);
          }
          else {
            final _warningToast = SnackBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              backgroundColor: COLOR_CONCORDIA,
              content: Text("You have no upcoming classes"),
            );
            _scaffoldKey.currentState.removeCurrentSnackBar();
            _scaffoldKey.currentState.showSnackBar(_warningToast);
          }
        }
      )
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
        markersPositionBottom: 9,
        weekendStyle: TextStyle(color: constant.COLOR_CONCORDIA),
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
                ),
              ))
          .toList(),
    );
  }
}
