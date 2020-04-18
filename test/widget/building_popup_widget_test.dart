import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/widget/building_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }

  testWidgets('Testing the Building Popup widget', (WidgetTester tester) async {
    var notifier = MapNotifier();
    notifier.showInfo = true;

    await tester.pumpWidget(makeTestableWidget(
      child: ChangeNotifierProvider(
        create: (_) => notifier,
        child: BuildingPopup(),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
    expect(find.byType(RaisedButton), findsOneWidget);
    expect(find.byIcon(Icons.my_location), findsOneWidget);

  });
}
