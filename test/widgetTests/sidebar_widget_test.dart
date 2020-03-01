import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:concordi_around/widgets/drawer.dart';

void main() {
  //need this since we need a mediaQuery ancestor such as materialapp
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Testing the SideBar widget', (WidgetTester tester) async {
    //building the sidebar
    //SidebarDrawer is created inside of a scaffold so we need to make it inside a materialapp
    await tester.pumpWidget(makeTestableWidget(child: SidebarDrawer()));
    await tester.pump();

    //making sure that the side bar exists and everything we need is there
    expect(find.byType(SidebarDrawer), findsOneWidget);
    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(4));

    //making sure that the correct logos are placed
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.message), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });
}