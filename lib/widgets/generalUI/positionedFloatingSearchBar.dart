import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

class PositionedFloatingSearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PositionedFloatingSearchBarState();
  }
}

class _PositionedFloatingSearchBarState
    extends State<PositionedFloatingSearchBar> {

      GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "AIzaSyAzsZ2URCqgDm9aJcduUyXVot5TEIANu6w");
      bool isTyping = false;
      String campus = "SGW";

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 5.0,
      right: 15,
      left: 15,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Row(
          children: <Widget>[
            Container(
              child: isTyping
                  ? IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    )
                    :
                    IconButton(
                      splashColor: Colors.grey,
                      icon: Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
            ),
            Expanded(
              child: TextField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintText: "Search..."),
                onTap: (){
                  
                  // setState(() {
                  //   isTyping = true;
                  // });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: 
                RaisedButton(
                  child: Text(campus),
                  textColor: Colors.white,
                  color: Color.fromRGBO(147, 35, 57, 1),
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50)),
                  onPressed: (){
                    setState(() {
                      // Use this at toggle text between SGW and Loyola
                      // if(campus == "SGW")
                      // campus = "LOY";
                      // else 
                      // campus = "SGW";
                    });
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Method for google prediction which we most likely wont use
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      var address = await Geocoder.local.findAddressesFromQuery(p.description);
      print(lat);
      print(lng);
    }
  }
}

