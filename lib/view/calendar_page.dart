import 'package:concordi_around/provider/calendar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:provider/provider.dart';

class MyCalendar extends StatefulWidget {
  MyCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> with TickerProviderStateMixin {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

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
    //  Provider.of<CalendarNotifier>(context).setEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarNotifier>(
        //      <--- ChangeNotifierProvider
        create: (context) => CalendarNotifier(),
        child: Scaffold(
          appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.dehaze, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(widget.title),
              backgroundColor: constant.COLOR_CONCORDIA),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Consumer<CalendarNotifier>(
                //                    <--- Consumer
                builder: (context, myModel, child) {
                  return _buildTableCalendar(myModel);
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(child: _buildEventList()),
            ],
          ),
        ));
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar(myModel) {
    // var eventsNotifier = Provider.of<CalendarNotifier>(context);
    return TableCalendar(
      calendarController: _calendarController,
      events: myModel.events,
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
                  onTap: () => print('$event tapped!'),
                ),
              ))
          .toList(),
    );
  }
}
