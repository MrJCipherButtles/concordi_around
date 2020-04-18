import 'package:concordi_around/main.dart';
import 'package:concordi_around/provider/direction_notifier.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/widget/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() {
  MapNotifier mn = MapNotifier();
  DirectionNotifier dn = DirectionNotifier();
  BuildContext context;

  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Testing the map widget', (WidgetTester tester) async {
    //build the app
    await tester.pumpWidget(makeTestableWidget(
        child: MultiProvider(providers: [
      ChangeNotifierProvider<MapNotifier>(create: (context) => mn),
      ChangeNotifierProvider<DirectionNotifier>(create: (context) => dn),
    ], child: MyApp())));
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
  testWidgets('Testing the map widget 2', (WidgetTester tester) async {
    dn.setShowDirectionPanel(true);
    mn.setFloorPlanVisibility(true);

    //build the app
    await tester.pumpWidget(makeTestableWidget(
        child: MultiProvider(providers: [
      ChangeNotifierProvider<MapNotifier>(create: (context) => mn),
      ChangeNotifierProvider<DirectionNotifier>(create: (context) => dn),
    ], child: MyApp())));
    await tester.pumpAndSettle();

    expect(find.byType(GoogleMap), findsOneWidget);
    expect(find.text('SGW'), findsOneWidget);

    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    await tester.tap(find.text('8'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('9'));
    await tester.pumpAndSettle();

    expect(find.text('8'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);
    //expect(find.byType(SlidingUpPanel), findsOneWidget);
  });
}
