import 'package:concordi_around/data/building_singleton.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordi_around/provider/direction_notifier.dart';
import 'package:concordi_around/model/building.dart';

void main() {
  group("Direction Notifier Unit tests: ", () {
    test('Initial values should be correct', () {
      var dn = DirectionNotifier();
      dn.clearAll();

      expect(dn.showDirectionPanel, false);
      expect(dn.mode, DrivingMode.walking);
      expect(dn.direction, null);
      expect(dn.getDirection(), null);
      expect(dn.directionSteps, List());
      expect(dn.getStepDirections(), List());
      expect(dn.polylines, []);
      expect(dn.getPolylines(), []);
      expect(dn.duration, '0 min');
      expect(dn.totalDuration, 0);
      expect(dn.getDuration(), '0 min');
      expect(dn.totalDistance, 0);
      expect(dn.apiCallCounter, 0);
    });

    test('Setter methods should work as expected', () {
      var dn = DirectionNotifier();

      dn.setShowDirectionPanel(true);
      expect(dn.showDirectionPanel, true);

      //Testing the Driving modes
      dn.setDrivingMode(DrivingMode.bicycling);
      expect(dn.mode, DrivingMode.bicycling);
      dn.setDrivingMode(DrivingMode.driving);
      expect(dn.mode, DrivingMode.driving);
      dn.setDrivingMode(DrivingMode.transit);
      expect(dn.mode, DrivingMode.transit);
    });

    //TODO: Test Navigation by coordinates
    test('Navigating by name', () {
      DirectionNotifier directionNotifier = DirectionNotifier();
      //Future<Direction> futureDirection = directionNotifier.navigateByCoordinates(originCoordinates, destinationCoordinates);
    });
  });
}
