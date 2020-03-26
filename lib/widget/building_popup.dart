import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:provider/provider.dart';
import 'package:concordi_around/credential.dart';
import 'package:dio/dio.dart';
import 'package:concordi_around/service/map_constant.dart';

class BuildingPopup extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BuildingPopupState();
  }
}

class _BuildingPopupState extends State<BuildingPopup> {
  
  List<String> pictures = List<String>();
  LatLng currentPlace =  LatLng(0, 0);
  String name = '';
  String address = '';
  String phone = '';
  String website = '';
  String openClosed = '';

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    if(currentPlace != mapNotifier.selectedLatlng){
      currentPlace = mapNotifier.selectedLatlng;
      _getBuildingDetails(currentPlace);
    }
    
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
  
    return Visibility(
      visible: mapNotifier.showInfo,
      child: SlidingUpPanel(
        minHeight: 80,
        maxHeight: 450,
        borderRadius: radius,
        backdropEnabled: true,
        panelBuilder: (ScrollController sc) => _scrollingList(sc),
        collapsed: Container(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => {
                  mapNotifier.setPopupInfoVisibility(false)
                },
              ),
            ],
          )
        ),
      )
    );
  }

  Widget _scrollingList(ScrollController sc){
    return ListView(
      controller: sc,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.grey[300])
            )
          ),
          height: 60,
          width: 75,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 20,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Positioned(
                top: 28,
                left: 20,
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.grey[300])
            )
          ),
          height: 50,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 12,
                left: 20,
                child:
                  Icon(Icons.phone, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 16,
                left: 80,
                child: Text(
                  phone,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.grey[300])
            )
          ),
          height: 50,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 12,
                left: 20,
                child:
                  Icon(Icons.public, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 16,
                left: 80,
                child: Text(
                  website,
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.grey[300])
            )
          ),
          height: 50,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 12,
                left: 20,
                child:
                  Icon(Icons.schedule, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 16,
                left: 80,
                child: Text(
                  openClosed,
                  style: TextStyle(
                    fontSize: 14, 
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 168,
          child: ListView.builder(
            itemCount: pictures.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Image(
              image: NetworkImage(pictures[index]),
            )
          )
        ),
        ButtonTheme(
          height: 48,
          child: RaisedButton(
            onPressed: (){
            },
            color: COLOR_CONCORDIA,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.directions,
                  color: Colors.white,
                ),
                Text(
                  '  Directions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  )
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Future<void> _getBuildingDetails(LatLng latLng) async {
    String baseURL = 'https://maps.googleapis.com/maps/api';
    double lat = latLng.latitude;
    double lng = latLng.longitude;

    String geocodingRequest = '$baseURL/geocode/json?latlng=$lat,$lng&result_type=point_of_interest|premise&key=$PLACES_API_KEY';
    Response geocodingResponse = await Dio().get(geocodingRequest);

    if(geocodingResponse.data['status'] == 'OK'){
      final geoResult = geocodingResponse.data['results'];
      String placeId = geoResult[0]['place_id'];
      String detailsRequest = '$baseURL/place/details/json?place_id=$placeId&key=$PLACES_API_KEY';
      Response detailsResponse = await Dio().get(detailsRequest);
      final result = detailsResponse.data['result'];

      name = result['name'];

      if(result['formatted_phone_number'] != null){
        phone = result['formatted_phone_number'];
      }else{
        phone = 'Information Not Available';
      }

      if(result['website'] != null){
        website = result['website'];
      }else{
        website = 'Information Not Available';
       }

      if(result['opening_hours'] != null){
        if(result['opening_hours']['open_now']){
          openClosed = "Open Now";
        }else{
          openClosed = "Closed";
        }
      }else{
        openClosed = 'Information Not Available';
      }

      String formattedAddress = result['formatted_address'];
      address = formattedAddress.substring(0, formattedAddress.length - 16);

      dynamic photosResult = result['photos'];
      pictures.clear();

      if(photosResult != null && result['photos'].length > 2){
        for(int i = 0; i < result['photos'].length; i++){
          String photoRef = photosResult[i]['photo_reference'];
          String picture = '$baseURL/place/photo?maxwidth=500&photoreference=$photoRef&key=$PLACES_API_KEY';
          pictures.add(picture);
        }
      }
    }
  }
}

