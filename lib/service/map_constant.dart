import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const Color COLOR_CONCORDIA = Color.fromRGBO(147, 35, 57, 1);

const double BORDER_RADIUS = 20;

const double CAMERA_DEFAULT_ZOOM = 17.2;
const double CAMERA_INDOOR_ZOOM = 18.5;
const double CAMERA_DEFAULT_TILT = 40;

const LatLng LATLNG_SGW = LatLng(45.495536, -73.577974);
const LatLng LATLNG_HALL = LatLng(45.49726709926478, -73.57894677668811);
const LatLng LATLNG_webster = LatLng(45.496691, -73.578171);
const LatLng LATLNG_GM = LatLng(45.495796, -73.578433);
const LatLng LATLNG_EV = LatLng(45.495668, -73.577689);
const LatLng LATLNG_JMSB = LatLng(45.495312, -73.579033);
const LatLng LATLNG_LOYOLA = LatLng(45.458279, -73.640436);
const LatLng LATLNG_SP = LatLng(45.457914, -73.641557);

enum DrivingMode {
  driving,
  walking,
  bicycling,
  transit,
  shuttle
} // Do not use toString method here to get value
