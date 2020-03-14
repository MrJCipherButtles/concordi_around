import 'dart:convert';

import 'package:concordi_around/model/direction.dart';
import 'package:concordi_around/model/list_item.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import '../credential.dart';

class MapDirection {

  var uuid = Uuid();
  String _sessionToken;

    // Google Directions API requests
  Future<List<ListItem>> _getDirection(String origin, String destination) async {
    if (origin.isEmpty || destination.isEmpty) {
      throw("Origin or destination is empty");
    }
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    
    String baseURL = 'https://maps.googleapis.com/maps/api/directions/json';

    String request = '$baseURL?origin=$origin&destination=$destination&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
    Response response = await Dio().get(request);

    print(response.data);

    final jsonResponse = json.decode(response.data);
    Direction direction = new Direction.fromJson(jsonResponse);

    print(direction);

  }
}