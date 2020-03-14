import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:concordi_around/data/data_points.dart';

class MarkerHelper {
  Set<Marker> eightfloorMarker = {};
  Set<Marker> ninthfloorMarker = {};

  MarkerHelper(BitmapDescriptor pinLocationIcon) {
    floorMarkers['8'].forEach((f) => eightfloorMarker.add(Marker(
        markerId: MarkerId(f.roomId),
        icon: pinLocationIcon,
        infoWindow: InfoWindow(title: f.roomId),
        position: f.toLatLng())));
    
    floorMarkers['9'].forEach((f) => ninthfloorMarker.add(Marker(
        markerId: MarkerId(f.roomId),
        icon: pinLocationIcon,
        infoWindow: InfoWindow(title: f.roomId),
        position: f.toLatLng())));
  }

  Set<Marker> getFloorMarkers(int selectedFloor) {
    return selectedFloor == 8 ? eightfloorMarker : ninthfloorMarker;
  }
}
