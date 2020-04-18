import 'package:concordi_around/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Testing the calendar page widget', (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(640, 640));
    //building the application
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.directions), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);

    //open sidebar to reach the calendar page
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    expect(find.text('My Calendar'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);

    await tester.tap(find.text('My Calendar'));
    await tester.pumpAndSettle();

    expect(find.text('My Calendar'), findsOneWidget);
    expect(find.byType(TableCalendar), findsOneWidget);
  });
}