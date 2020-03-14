import 'dart:convert';

import 'package:concordi_around/model/direction.dart';
import 'package:dio/dio.dart';

import '../credential.dart';

class MapDirection {

    // Google Directions API requests
  Direction getDirection(String origin, String destination, String mode) {
    if (origin.isEmpty || destination.isEmpty) {
      throw ("Origin or destination is empty");
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/directions/json';

    String request = '$baseURL?origin=$origin&destination=$destination&mode=$mode&key=$DIRECTIONS_API_KEY';
    Response response = await Dio().get(request);

    final jsonResponse = json.decode(response.data);
    Direction direction = Direction.fromJson(jsonResponse);

    print(direction);

    return direction;
  }
}
