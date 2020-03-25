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
  
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
  
    return Visibility(
      visible: mapNotifier.showInfo,
      child: SlidingUpPanel(
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
          height: 75,
          width: 75,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 9,
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
                top: 37,
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
          height: 60,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 18,
                left: 20,
                child:
                  Icon(Icons.phone, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 22,
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
          height: 60,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 18,
                left: 20,
                child:
                  Icon(Icons.public, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 22,
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
          height: 60,
          width: 60,
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Positioned(
                top: 18,
                left: 20,
                child:
                  Icon(Icons.schedule, color: COLOR_CONCORDIA)
              ),
              Positioned(
                top: 22,
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
          height: 173,
          child: ListView.builder(
            itemCount: pictures.length > 2 ? pictures.length : 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Image(
              image: NetworkImage(pictures[index]),
            )
          )
        ),
        ButtonTheme(
          height: 48,
          child: RaisedButton(
            onPressed: (){},
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
}