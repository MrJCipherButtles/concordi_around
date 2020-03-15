import 'dart:convert';

import 'package:concordi_around/credential.dart';
import 'package:concordi_around/model/direction.dart';
import 'package:dio/dio.dart';

class MapDirection {
  Direction currentDirection;

    // Google Directions API requests
  Future<Direction> getDirection(String origin, String destination, String mode) async {
    if (origin.isEmpty || destination.isEmpty) {
      throw ("Origin or destination is empty");
    }

    String baseURL = 'https://maps.googleapis.com/maps/api/directions/json';

    String request = '$baseURL?origin=$origin&destination=$destination&mode=$mode&key=$DIRECTIONS_API_KEY';
    Response response = await Dio().get(request);

    final jsonResponse = jsonDecode(response.toString());
    currentDirection = Direction.fromJson(jsonResponse);

    return currentDirection;
  }
}
