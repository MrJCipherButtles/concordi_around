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
    expect(find.byIcon(Icons.arrow_back), findsWidgets);
    expect(find.byType(TextField), findsWidgets);
    expect(find.byType(Container), findsWidgets);
    expect(find.byType(Material), findsWidgets);
    expect(find.byType(Column), findsWidgets);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.byType(Navigator), findsWidgets);
    expect(find.byType(SizedBox), findsWidgets);
    expect(find.byType(Expanded), findsWidgets);
    expect(find.byType(Card), findsWidgets);
    expect(find.byType(Center), findsWidgets);
    expect(find.byType(FloatingActionButton), findsWidgets);
    expect(find.byType(Align), findsWidgets);

    //TODO: Find the existence of the two origin and destination search boxes
  });
}
