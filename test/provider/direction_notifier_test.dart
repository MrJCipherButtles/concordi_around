import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordi_around/provider/direction_notifier.dart';

void main() {
  test('Should be in SGW with no floor plans shown', () {
    var dn = DirectionNotifier();

    expect(dn.showDirectionPanel, false);
    expect(dn.mode, DrivingMode.walking);

    dn.setShowDirectionPanel(true);
    expect(dn.showDirectionPanel, true);

    dn.setDrivingMode(DrivingMode.bicycling);
    expect(dn.mode, DrivingMode.bicycling);
    dn.setDrivingMode(DrivingMode.driving);
    expect(dn.mode, DrivingMode.driving);
    dn.setDrivingMode(DrivingMode.transit);
    expect(dn.mode, DrivingMode.transit);
  });
}
