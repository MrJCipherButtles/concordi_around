import 'dart:async';
import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:path/path.dart';
import 'package:flutter/widgets.dart';


void main() {
  Future delay([int milliseconds = 100]) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }

  group('Counter App', () {
    FlutterDriver driver;

    setUpAll(() async {
      final envVars = Platform.environment;
      final adbPath = join(
        envVars['ANDROID_SDK_ROOT'] ?? envVars['ANDROID_HOME'],
        'platform-tools',
        Platform.isWindows ? 'adb.exe' : 'adb',
      );
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

    //User Story: current location
    test(
      'US#: Find my current location',
      () async {
        final SerializableFinder myLocation = find.byTooltip('Get Location');
        await Future.delayed(Duration(seconds: 8));
        await driver.tap(myLocation);
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    test(
      'US#: Toggle between campuses',
      () async {
        final SerializableFinder myLocation = find.byTooltip('Get Location');
        await Future.delayed(Duration(seconds: 8));
        await driver.tap(find.text('SGW'));
        await Future.delayed(Duration(seconds: 3));
        await driver.tap(find.text('LOY'));
        await Future.delayed(Duration(seconds: 3));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    
    //User story: indoor directions (check if text is sgw and if toggle floor buttons is there)
    test(
      'US#: Provide indoor directions',
      () async {
        final SerializableFinder myLocation = find.byTooltip('Directions');
        await driver.tap(myLocation);

        //enter starting location
        await driver.tap(find.byValueKey(Key('Origin Field')));
        await driver.enterText('H811');
        await driver.waitFor(find.text('H811'));
        await driver.tap(find.text('H811'));

        //enter destination
        await driver.tap(find.byValueKey(Key('Destination Field')));
        await driver.enterText('H860');
        await driver.waitFor(find.text('H860'));
        await driver.tap(find.text('H860'));
      },
      timeout: Timeout(
        Duration(minutes: 1),
      ),
    );

    //User story: indoor directions (disability mode)

    //User story: Shuttle schedule (click drawer and click shuttle schedule)

    // test('increments the counter', () async {
    //   // First, tap the button.
    //   await driver.tap(buttonFinder);

    //   // Then, verify the counter text is incremented by 1.
    //   expect(await driver.getText(counterTextFinder), "1");
    // });
  });
}

