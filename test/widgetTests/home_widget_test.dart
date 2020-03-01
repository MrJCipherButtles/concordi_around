import 'package:concordi_around/main.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  testWidgets('Testing the Home widget', (WidgetTester tester) async {
    //building the application
    await tester.pumpWidget(MyApp());

    //testing to see if the map in the background is there
    expect(find.byType(GoogleMap), findsOneWidget);

    //making sure the correct buttons are located originally:
    expect(find.byType(FloatingActionButton), findsNWidgets(2));
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.byIcon(Icons.directions), findsOneWidget);
    expect(find.byType(SearchBar), findsOneWidget);
  });
}