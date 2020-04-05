import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('ConcordiAround', () {
    FlutterDriver driver;

    setUpAll(() async {
      // Make sure environment variable ANDROID_SDK_ROOT is set to path to Android sdk folder
      final Map<String, String> envVars = Platform.environment;
      final String root =
          envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'];
      final String adbPath = root + '/platform-tools/adb';
      await Process.run(adbPath, [
        'shell',
        'pm',
        'grant',
        'ca.concordia.w20.soen390.concordi_around', // replace with your app id
        'android.permission.ACCESS_FINE_LOCATION',
        'android.permission.ACCESS_BACKGROUND_LOCATION',
        'android.permission.WAKE_LOCK'
      ]);
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(
      'US-8: Find my current location',
      () async {
        final SerializableFinder myLocation = find.byTooltip('Get Location');
        await Future.delayed(Duration(seconds: 5));
        await driver.tap(myLocation);
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'US-10: Toggle between campuses',
      () async {
        await Future.delayed(Duration(seconds: 5));
        await driver.tap(find.text('SGW'));
        await Future.delayed(Duration(seconds: 3));
        await driver.tap(find.text('LOY'));
        await Future.delayed(Duration(seconds: 3));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    var indoorStories = {
      12: {'story': 'Indoor Directions', 'start': 'H811', 'dest': 'H860'},
      26: {
        'story': 'Travel between buildings',
        'start':
            'Hall Building Auditorium, Boulevard de Maisonneuve Ouest, Montréal, QC, Canada',
        'dest':
            'John Molson School of Business, Guy Street, Montréal, QC, Canada'
      }
    };

    indoorStories.forEach((k, v) => test(
          'US-$k: ${v['story']}',
          () async {
            final SerializableFinder myLocation =
                find.byTooltip('direction page button');
            await Future.delayed(Duration(seconds: 5));
            await driver.tap(myLocation);
            await Future.delayed(Duration(seconds: 5));

            //enter starting location
            await driver.tap(find.byValueKey('Origin Field'));
            await Future.delayed(Duration(seconds: 1));
            await driver.enterText('${v['start']}');
            await Future.delayed(Duration(seconds: 2));
            await driver.scrollUntilVisible(
                find.byValueKey("search_list"), find.byValueKey("list_text"),
                dyScroll: -100.0);
            await Future.delayed(Duration(seconds: 1));
            expect(await driver.getText(find.byValueKey("list_text")),
                '${v['start']}');
            driver.tap(find.byValueKey("list_text"));
            await Future.delayed(Duration(seconds: 1));

            //enter destination
            await driver.tap(find.byValueKey('Destination Field'));
            await Future.delayed(Duration(seconds: 1));
            await driver.enterText('${v['dest']}');
            await Future.delayed(Duration(seconds: 2));
            await driver.scrollUntilVisible(
                find.byValueKey("search_list"), find.byValueKey("list_text"),
                dyScroll: -100.0);
            await Future.delayed(Duration(seconds: 1));
            expect(await driver.getText(find.byValueKey("list_text")),
                '${v['dest']}');
            driver.tap(find.byValueKey("list_text"));

            //select mode of transport
            await Future.delayed(Duration(seconds: 3));
            await driver.tap(find.byValueKey("walk"));

            //tap go button
            await Future.delayed(Duration(seconds: 4));
            await driver.tap(find.byValueKey("go button"));
            await Future.delayed(Duration(seconds: 4));

            //closing the direction menu
            await driver.tap(find.byValueKey('Direction Panel close'));
            await Future.delayed(Duration(seconds: 5));
          },
          timeout: Timeout(
            Duration(minutes: 1),
          ),
        ));

    var transportationMethods = {
      14: 'walk',
      17: 'transit',
      16: 'shuttle',
      15: 'bike',
      18: 'car'
    };
    transportationMethods.forEach((k, v) => test(
          'US-$k: Outdoor Directions from starting location with transportation method: $v',
          () async {
            final SerializableFinder myLocation =
                find.byTooltip('direction page button');
            await Future.delayed(Duration(seconds: 1));
            await driver.tap(myLocation);
            await Future.delayed(Duration(seconds: 1));

            //enter destination
            await driver.tap(find.byValueKey('Destination Field'));
            await Future.delayed(Duration(seconds: 1));
            await driver.enterText('H860');
            await Future.delayed(Duration(seconds: 2));
            await driver.scrollUntilVisible(
                find.byValueKey("search_list"), find.byValueKey("list_text"),
                dyScroll: -100.0);
            await Future.delayed(Duration(seconds: 1));
            expect(await driver.getText(find.byValueKey("list_text")), "H860");
            driver.tap(find.byValueKey("list_text"));

            //select mode of transport
            await Future.delayed(Duration(seconds: 1));
            await driver.tap(find.byValueKey('$v'));

            //tap go button
            await Future.delayed(Duration(seconds: 3));
            await driver.tap(find.byValueKey("go button"));
            await Future.delayed(Duration(seconds: 3));

            //closing the direction menu
            await driver.tap(find.byValueKey('Direction Panel close'));
          },
          timeout: Timeout(
            Duration(minutes: 1),
          ),
        ));
  });
}
