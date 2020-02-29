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

  testWidgets('Testing the SideBar widget', (WidgetTester tester) async {
    //building the application and opening the sidebar
    // await tester.pumpWidget(SidebarDrawer());
    // await tester.pump();

    // await tester.pumpWidget(makeTestableWidget(child: SidebarDrawer()));
    // await tester.pump();

    await tester.pumpWidget(MyApp());

    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(find.byType(SidebarDrawer), findsOneWidget);

    expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
  });
}