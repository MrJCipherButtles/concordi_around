import 'package:concordi_around/widget/direction_panel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:concordi_around/service/map_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  group("Direction Panel Unit tests:", () {
    DirectionPanelState directionPanelState = DirectionPanelState();
    test('Custom Icon Should be Reuired', () {
      expect(directionPanelState.isCustomIconRequired('left'), true);
      expect(directionPanelState.isCustomIconRequired('right'), true);
      expect(directionPanelState.isCustomIconRequired('head'), true);
      expect(directionPanelState.isCustomIconRequired('continue'), true);
      expect(
          directionPanelState.isCustomIconRequired('eftighteadontinue'), false);
      expect(directionPanelState.isCustomIconRequired(''), false);
    });

    test('Custom Direction Icon should be returned', () {
      expect(directionPanelState.getCustomDirectionIcon("slight left").image,
          AssetImage("assets/direction_icon/slight_left.png"));
      expect(directionPanelState.getCustomDirectionIcon("slight right").image,
          AssetImage("assets/direction_icon/slight_right.png"));
      expect(directionPanelState.getCustomDirectionIcon("turn left").image,
          AssetImage("assets/direction_icon/turn_left.png"));
      expect(directionPanelState.getCustomDirectionIcon("turn right").image,
          AssetImage("assets/direction_icon/turn_right.png"));
      expect(
          directionPanelState
              .getCustomDirectionIcon("light eft light ight")
              .image,
          AssetImage("assets/direction_icon/straight.png"));
    });

    test('Standard Direction Icon should be returned', () {
      expect(directionPanelState.getDirectionIcon('walk').icon,
          Icons.directions_walk);
      expect(directionPanelState.getDirectionIcon('bus').icon,
          Icons.directions_bus);
      expect(directionPanelState.getDirectionIcon('shuttle').icon,
          Icons.airport_shuttle);
      expect(directionPanelState.getDirectionIcon('walk').icon,
          Icons.directions_walk);
      expect(directionPanelState.getDirectionIcon('subway').icon,
          Icons.directions_subway);
      expect(directionPanelState.getDirectionIcon('alkuhutleuway').icon,
          Icons.info);
      expect(directionPanelState.getDirectionIcon('').icon, Icons.info);
    });

    test('Mode Icon should be returned', () {
      expect(directionPanelState.getModeIcon(DrivingMode.driving).icon,
          Icons.directions_car);
      expect(directionPanelState.getModeIcon(DrivingMode.transit).icon,
          Icons.directions_transit);
      expect(directionPanelState.getModeIcon(DrivingMode.bicycling).icon,
          Icons.directions_bike);
      expect(directionPanelState.getModeIcon(DrivingMode.shuttle).icon,
          Icons.airport_shuttle);
      expect(directionPanelState.getModeIcon(DrivingMode.walking).icon,
          Icons.directions_walk);
    });
  });
}
