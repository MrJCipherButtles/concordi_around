import 'package:concordi_around/model/direction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Direction Unit Tests', () {
    LocationModel locMod1 = LocationModel(lat: 10.0, lng: 20.0);
    LocationModel locMod2 = LocationModel(lat: 30.0, lng: 40.0);
    PolylineModel pm = PolylineModel(points: 'all points');
    Duration dur = Duration(value: 10, text: 'minutes');
    Distance dist = Distance(value: 10, text: "km");

    Steps stps = Steps(
        travelMode: 'Driving',
        startLocation: locMod1,
        endLocation: locMod2,
        polyline: pm,
        duration: dur,
        distance: dist,
        htmlInstructions: "Instructions");
    List<Steps> stepsList = new List(1);
    stepsList[0] = stps;

    Legs lgs = Legs(steps: stepsList, distance: dist, duration: dur);
    List<Legs> legsList = new List(1);
    legsList[0] = lgs;

    Routes rts = Routes(
        summary: 'full summary',
        legs: legsList,
        startLocation: locMod1,
        endLocation: locMod2,
        startAddress: 'the start address',
        endAddress: 'the end address');
    List<Routes> routesList = new List(1);
    routesList[0] = rts;

    Direction dir = Direction(routes: routesList);

    test('Duration unit test', () {
      Map<String, dynamic> json = dur.toJson();

      expect(json, {'value': 10, 'text': 'minutes'});
      Duration.fromJson(json);
      expect(dur.value, 10);
      expect(dur.text, 'minutes');
    });

    test('Distance unit test', () {
      Map<String, dynamic> json = dist.toJson();
      expect(json, {'value': 10, 'text': 'km'});

      Distance.fromJson(json);
      expect(dist.value, 10);
      expect(dist.text, 'km');
    });

    test('PolylineModel Unit Test', () {
      Map<String, dynamic> json = pm.toJson();
      expect(json, {'points': 'all points'});

      PolylineModel.fromJson(json);
      expect(pm.points, 'all points');
    });

    test('LocationModel unit test', () {
      Map<String, dynamic> json = locMod1.toJson();
      expect(json, {'lat': 10.0, 'lng': 20.0});

      LocationModel.fromJson(json);
      expect(locMod1.lat, 10.0);
      expect(locMod1.lng, 20.0);
    });

    test('Steps unit test', () {
      Map<String, dynamic> json = stps.toJson();

      expect(json, {
        'travel_mode': 'Driving',
        'start_location': {'lat': 10.0, 'lng': 20.0},
        'end_location': {'lat': 30.0, 'lng': 40.0},
        'polyline': {'points': 'all points'},
        'duration': {'value': 10, 'text': 'minutes'}
      });

      Steps.fromJson(json);
      expect(stps.travelMode, 'Driving');
      expect(stps.startLocation, locMod1);
      expect(stps.endLocation, locMod2);
      expect(stps.polyline, pm);
      expect(stps.duration, dur);
    });

    test('Legs unit test', () {
      Map<String, dynamic> json = lgs.toJson();

      expect(json, {
        'steps': [
          {
            'travel_mode': 'Driving',
            'start_location': {'lat': 10.0, 'lng': 20.0},
            'end_location': {'lat': 30.0, 'lng': 40.0},
            'polyline': {'points': 'all points'},
            'duration': {'value': 10, 'text': 'minutes'}
          }
        ],
        'distance': {'value': 10, 'text': 'km'},
        'duration': {'value': 10, 'text': 'minutes'}
      });

      Legs.fromJson(json);
      expect(lgs.steps, stepsList);
      expect(lgs.distance, dist);
      expect(lgs.duration, dur);
    });

    test('Routes unit test', () {
      Map<String, dynamic> json = rts.toJson();

      expect(json, {
        'summary': 'full summary',
        'legs': [
          {
            'steps': [
              {
                'travel_mode': 'Driving',
                'start_location': {'lat': 10.0, 'lng': 20.0},
                'end_location': {'lat': 30.0, 'lng': 40.0},
                'polyline': {'points': 'all points'},
                'duration': {'value': 10, 'text': 'minutes'}
              }
            ],
            'distance': {'value': 10, 'text': 'km'},
            'duration': {'value': 10, 'text': 'minutes'}
          }
        ],
        'start_location': {'lat': 10.0, 'lng': 20.0},
        'end_location': {'lat': 30.0, 'lng': 40.0},
        'start_address': 'the start address',
        'end_address': 'the end address'
      });

      Routes.fromJson(json);
      expect(rts.legs, legsList);
      expect(rts.startLocation, locMod1);
      expect(rts.endLocation, locMod2);
      expect(rts.startAddress, 'the start address');
      expect(rts.endAddress, 'the end address');
    });

    test('Direction unit test', () {
      Map<String, dynamic> json = dir.toJson();

      expect(json, {
        'routes': [
          {
            'summary': 'full summary',
            'legs': [
              {
                'steps': [
                  {
                    'travel_mode': 'Driving',
                    'start_location': {'lat': 10.0, 'lng': 20.0},
                    'end_location': {'lat': 30.0, 'lng': 40.0},
                    'polyline': {'points': 'all points'},
                    'duration': {'value': 10, 'text': 'minutes'}
                  }
                ],
                'distance': {'value': 10, 'text': 'km'},
                'duration': {'value': 10, 'text': 'minutes'}
              }
            ],
            'start_location': {'lat': 10.0, 'lng': 20.0},
            'end_location': {'lat': 30.0, 'lng': 40.0},
            'start_address': 'the start address',
            'end_address': 'the end address'
          }
        ]
      });
    });
  });
}
