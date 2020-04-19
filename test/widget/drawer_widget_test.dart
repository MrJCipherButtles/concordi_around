import 'package:concordi_around/view/shuttle_page.dart';
import 'package:concordi_around/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordi_around/main.dart';

void main() {
  testWidgets('Testing the SideBar widget', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    //making sure that the side bar exists and everything we need is there
    expect(find.byType(SidebarDrawer), findsOneWidget);
    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(CheckboxListTile), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(6));

    //making sure that the correct logos are placed
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.airport_shuttle), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.message), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
    expect(find.byIcon(Icons.accessible_forward), findsOneWidget);

    //making sure the correct text is placed
    expect(find.text('My Calendar'), findsOneWidget);
    expect(find.text('Shuttle Schedule'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Contact Us'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Disability Mode'), findsOneWidget);
    expect(find.text('User Unavailable'), findsOneWidget);
    expect(find.text('Sign in with My Calendar'), findsOneWidget);

    //Verifying shuttle schedule button leads to the right page
    await tester.tap(find.byIcon(Icons.airport_shuttle));
    await tester.pumpAndSettle();
    expect(find.byType(ShuttlePage), findsOneWidget);
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    //Making sure disability button works
    await tester.tap(find.text('Disability Mode'));
    await tester.pump();
    expect(find.byType(SnackBarAction), findsOneWidget);
    expect(find.text('Disability Mode turned ON'), findsOneWidget);
    expect(find.text('UNDO'), findsOneWidget);
  });
}
