import 'package:concordi_around/main.dart';
import 'package:concordi_around/widget/drawer.dart';
import 'package:concordi_around/widget/search/main_search_bar.dart';
import 'package:concordi_around/widget/search/search_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing the search widget', (WidgetTester tester) async {
    //Building the application
    await tester.pumpWidget(MyApp());

    //verify that the Text widgets appear exactly once in the widget tree.
    var searchButton = find.byType(SearchBar);
    expect(searchButton, findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
    

    //Testing the building list from search menu
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    expect(find.text('Search'), findsOneWidget);
    expect(find.byIcon(Icons.clear), findsOneWidget);
    expect(find.byType(SearchMenuListOption), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'h');
    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsOneWidget);
    
    await tester.tap(find.byType(AnimatedIcon));
    await tester.pumpAndSettle();

    //Testing the raised button
    var campusButton = find.byType(RaisedButton);

    expect(campusButton, findsOneWidget);
    expect(find.text('SGW'), findsOneWidget);
    await tester.tap(campusButton);
    await tester.pump();
    expect(find.text('LOY'), findsOneWidget);

    // //Testing the SideBarDrawer button
    var sidemenuButton = find.byType(IconButton);

    expect(sidemenuButton, findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    await tester.tap(sidemenuButton);
    await tester.pump();
    expect(find.byType(SidebarDrawer), findsOneWidget);

    //testing to see if the building list shows up
  });
}