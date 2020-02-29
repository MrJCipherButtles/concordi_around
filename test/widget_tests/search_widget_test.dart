import 'package:concordi_around/main.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:concordi_around/widgets/generalUI/sidebarDrawer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/widgets/generalUI/positionedFloatingSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Testing the search widget', (WidgetTester tester) async {
    //Building the application
    await tester.pumpWidget(MyApp());


    //await tester.pumpWidget(makeTestableWidget(child: SearchBar()));
    // await tester.pumpWidget(
    //   SearchBar(
    //                 name: (String building) =>
    //                     {_goToSelectedBuilding("Hall")})
    // );

    // verify that the Text widgets appear exactly once in the widget tree.
    expect(find.byType(SearchBar), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);

    //Testing the raised button
    var campusButton = find.byType(RaisedButton);

    expect(campusButton, findsOneWidget);
    expect(find.text('SGW'), findsOneWidget);
    await tester.tap(campusButton);
    await tester.pump();
    expect(find.text('LOY'), findsOneWidget);

    //Testing the SideBarDrawer button
    var sidemenuButton = find.byType(IconButton);

    expect(sidemenuButton, findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    await tester.tap(sidemenuButton);
    await tester.pump();
    expect(find.byType(SidebarDrawer), findsOneWidget);
  });
}