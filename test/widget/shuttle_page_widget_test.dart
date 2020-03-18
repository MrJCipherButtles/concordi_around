import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordi_around/view/shuttle_page.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  testWidgets('Testing the shuttle page widget', (WidgetTester tester) async {
    var campuses = ['Loyola', 'SGW'];

    //Running all checks for departures from both SGW and Loyola campus
    for (var startingCampus in campuses) {
      //Testing the shuttle bus widgets for loyola departures from SGW campus
      if (startingCampus == 'SGW') {
        await tester.tap(find.text('LOY'));
        await tester.pumpAndSettle();
      }

      for (var dayOfWeek = 1; dayOfWeek < 8; dayOfWeek++) {
        ShuttlePage sp = ShuttlePage(
            weekday: dayOfWeek, now: TimeOfDay(hour: 8, minute: 30));
        await tester.pumpWidget(makeTestableWidget(child: sp));
        await tester.pump();

        //Testing to make sure all proper widgets are accounted for
        expect(find.text('Shuttle Bus Departures'), findsOneWidget);
        expect(find.text('LOY'), findsWidgets);
        expect(find.text('SGW'), findsWidgets);
        expect(find.text(" " + startingCampus + ' Campus'), findsWidgets);
        expect(find.byType(Tab), findsNWidgets(2));
        expect(find.byType(DefaultTabController), findsOneWidget);

        //Testing the shuttle bus widgets for SGW departures from loyola campus
        expect(find.byIcon(Icons.airport_shuttle), findsWidgets);
        expect(find.byIcon(Icons.arrow_right), findsWidgets);
        expect(find.byIcon(Icons.accessible), findsWidgets);

        if (dayOfWeek == 6 || dayOfWeek == 7) {
          expect(find.text('Scheduled for Monday · '), findsWidgets);
        } else {
          expect(find.text('Scheduled · '), findsWidgets);
        }
      }
    }
  });
}
