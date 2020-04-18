import 'package:concordi_around/main.dart';
import 'package:concordi_around/widget/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  testWidgets('Testing the map widget', (WidgetTester tester) async {
    await tester.runAsync(() async {
      //build the app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();

      expect(find.byType(GoogleMap), findsOneWidget);
      expect(find.text('SGW'), findsOneWidget);

      //toogle the campus twice to go to SGW campus
      await tester.tap(find.text('SGW'));
      await tester.pumpAndSettle();
      expect(find.text('LOY'), findsOneWidget);

      await tester.tap(find.text('LOY'));
      await tester.pumpAndSettle();
      expect(find.text('SGW'), findsOneWidget);

      //tests the drag movement
      final gesture = await tester.startGesture(Offset(200, 300));
      await gesture.moveBy(Offset(0, -200));
      await tester.pump();

      expect(find.byType(GoogleMap), findsOneWidget);
      expect(find.byIcon(Icons.directions), findsOneWidget);

      //test the direction button
      await tester.tap(find.byIcon(Icons.my_location));
      await tester.pumpAndSettle();
    });
  });
}
