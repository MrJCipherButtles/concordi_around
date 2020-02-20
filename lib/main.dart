import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'points.dart';
import 'package:kdtree/kdtree.dart';
import 'package:collection/collection.dart';



void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMap _map = new GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        initialCameraPosition: CameraPosition(target: LatLng(45.497593, -73.578487), zoom: 18.5), 
        //CameraPosition(target: _initialPosition, zoom:18.5), 
        //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
      );
  // static LatLng _initialPosition;

  // @override
  // void initState() {
  //   super.initState();
  //   _getUserLocation();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _map ,
      floatingActionButton: FloatingActionButton(
        onPressed: fuckthis,
        tooltip: 'Get Location',
        child: Icon(Icons.location_on),
      ),
    );
  }

  // void _getUserLocation() async {
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     _initialPosition = LatLng(position.latitude, position.longitude);
  //   });
  // }

  Future<void> _goToCurrent() async {






    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    var currentLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    CameraPosition _currentPos = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 18.5);  

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_currentPos));
  }


  void fuckthis(){
    const LatLng _center = const LatLng(45.49719, -73.57884);
        const LatLng _end = const LatLng(45.49745, -73.57879);

final Set<Marker> _markers = {};
final Set<Polyline>_polyline={};

//add your lat and lng where you wants to draw polyline
LatLng _lastMapPosition = _center;
// List<LatLng> latlng = new Coords().pointsFromListMap(new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918)));
List<LatLng> latlng = new Coords().getPath();


// List<LatLng> pointsAB = new Coords().getPoints(LatLng(45.49719, -73.57933), LatLng(45.49735, -73.57918));
// List<LatLng> pointsBC = new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899));
// List<LatLng> pointsCY = new Coords().getPoints(LatLng(45.49735, -73.57918), LatLng(45.49755, -73.57899));



// LatLng _new = LatLng(45.49719, -73.57884);
// LatLng _news = LatLng(45.49721, -73.57888);
// LatLng _news1 = LatLng(45.4974, -73.57868);
// LatLng _news2 = LatLng(45.49745, -73.57879);



// latlng.add(_new);
// latlng.add(_news);
// latlng.add(_news1);
// latlng.add(_news2);



setState(() {
        _markers.add(Marker(
            // This marker id can be anything that uniquely identifies each marker.
            markerId: MarkerId(_lastMapPosition.toString()),
            //_lastMapPosition is any coordinate which should be your default 
            //position when map opens up
            position: _lastMapPosition,
            infoWindow: InfoWindow(
                title: 'Start',
                snippet: 'Goomba and Naima',
            ),
            icon: BitmapDescriptor.defaultMarker,

        ));
        _polyline.add(Polyline(
            polylineId: PolylineId(_lastMapPosition.toString()),
            visible: true,
            //latlng is List<LatLng>
            points: latlng,
            color: Colors.blue,
        ));

        });


         _map = new GoogleMap(
        mapType: MapType.normal,
        indoorViewEnabled: true,
        polylines:_polyline,
      
        
        initialCameraPosition: CameraPosition(target: LatLng(45.497593, -73.578487), zoom: 18.5), 
        //CameraPosition(target: _initialPosition, zoom:18.5), 
        //throws Failed assertion: line 22 of package google_maps_flutter/src/camera.dart
      );

      


        
  }

  


  

}


