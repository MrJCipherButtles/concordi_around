import 'package:concordi_around/main.dart';
import 'package:concordi_around/views/go_to_page.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

void main() {
  
  testWidgets('Testing the GoTo page', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.directions));
    await tester.pump();

    expect(find.byIcon(Icons.navigation), findsOneWidget);
    expect(find.byType(TypeAheadField), findsNWidgets(2));
    expect(find.text("origin..."), findsOneWidget);
    expect(find.text("destination..."), findsOneWidget);
  });
}