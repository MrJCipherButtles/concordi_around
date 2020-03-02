import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:concordi_around/views/go_to_page.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Testing the GoTo page', (WidgetTester tester) async {
    //Building the goto page
    await tester.pumpWidget(makeTestableWidget(child: GoToPage()));
    await tester.pump();

    //verifying all correct widgets are present
    expect(find.text("Choose starting location"), findsWidgets);
    expect(find.text("Choose destination"), findsWidgets);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.text('ETA (min) + Distance (m/km)'), findsOneWidget);

    //TODO: Find the existence of the two origin and destination search boxes
  });
}
