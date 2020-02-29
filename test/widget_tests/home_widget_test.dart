import 'package:concordi_around/main.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Testing the Home widget', (WidgetTester tester) async {
    //building the application
    await tester.pumpWidget(MyApp());

    //testing to see if the map in the background is there
    expect(find.byType(GoogleMap), findsOneWidget);

    //making sure the correcy buttons are located originally:
    expect(find.byType(FloatingActionButton), findsNWidgets(3));
    expect(find.byIcon(Icons.my_location), findsOneWidget);
    expect(find.byIcon(Icons.directions), findsOneWidget);

    //making sure the goinside button appears when hovering on top of hall building

  });
}