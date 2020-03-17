import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/view/goto_page_new.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  bool _testDrivingMode(Widget widget, int mode) {
    if (widget is ToggleButtons) {
      ToggleButtons testWidget = widget;
      if (testWidget.isSelected[mode] == true) {
        return true;
      }
    }
    return false;
  }

  testWidgets('Testing the GoTo page', (WidgetTester tester) async {
    //Building the goto page
    await tester.pumpWidget(makeTestableWidget(child: GotoPage(Position())));
    await tester.pumpAndSettle();

    //verifying all correct widgets are present
    expect(find.text('Your location'), findsWidgets);
    expect(find.text('Choose destination'), findsWidgets);
    expect(find.byType(FloatingActionButton), findsOneWidget);

    expect(find.byIcon(Icons.directions_car), findsOneWidget);
    await tester.tap(find.byIcon(Icons.directions_car));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) => _testDrivingMode(widget, 0)),
        findsOneWidget);

    expect(find.byIcon(Icons.directions_transit), findsOneWidget);
    await tester.tap(find.byIcon(Icons.directions_transit));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) => _testDrivingMode(widget, 1)),
        findsOneWidget);

    expect(find.byIcon(Icons.directions_bike), findsOneWidget);
    await tester.tap(find.byIcon(Icons.directions_bike));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) => _testDrivingMode(widget, 2)),
        findsOneWidget);

    expect(find.byIcon(Icons.directions_walk), findsOneWidget);
    await tester.tap(find.byIcon(Icons.directions_walk));
    await tester.pumpAndSettle();
    expect(find.byWidgetPredicate((widget) => _testDrivingMode(widget, 3)),
        findsOneWidget);

    //tap "GO" button before choosing a destination
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Testing the GoTo page with only Destination',
      (WidgetTester tester) async {
    //tap "GO" button with destination and no starting location
    await tester.pumpWidget(
      makeTestableWidget(
        child: GotoPage(
          Position(),
          destination: Coordinate(0, 0, '', 'TestBuilding', ''),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('TestBuilding'), findsOneWidget);
    expect(find.text('Your location'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(FloatingActionButton), findsOneWidget);

  });
}
