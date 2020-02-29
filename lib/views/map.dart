
import 'dart:async';

import 'package:concordi_around/provider/map_notifier.dart';
import 'package:concordi_around/services/map_helper.dart';
import 'package:concordi_around/widgets/floor_selector_enter_building_column.dart';
import 'package:concordi_around/widgets/search/main_search_bar.dart';
import 'package:concordi_around/widgets/svg_floor_plans.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Map extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MapState();
  }
}

class _MapState extends State<Map> {
  
  @override
  Widget build(BuildContext context) {
    return null;
  }
}