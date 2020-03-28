import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:concordi_around/provider/map_notifier.dart';
import 'package:provider/provider.dart';
import 'package:concordi_around/service/map_constant.dart' as constant;
import 'package:concordi_around/model/coordinate.dart';
import 'package:concordi_around/widget/search/main_search_bar.dart';

class BuildingPopup extends StatefulWidget {
  final VoidCallback onGetDirectionSelected;

  BuildingPopup({this.onGetDirectionSelected});

  State<StatefulWidget> createState() {
    return _BuildingPopupState();
  }
}

class _BuildingPopupState extends State<BuildingPopup> {
  List<String> _pictures = List<String>();
  LatLng currentPlace = LatLng(0, 0);
  String _name = '';
  String _address = '';
  String _phone = '';
  String _website = '';
  String _openClosed = '';

  @override
  Widget build(BuildContext context) {
    MapNotifier mapNotifier = Provider.of<MapNotifier>(context);

    if (currentPlace != mapNotifier.selectedLatlng) {
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
                    onPressed: () =>
                        {mapNotifier.setPopupInfoVisibility(false)},
                  ),
                ],
              )),
        ));
  }

  Widget _scrollingList(ScrollController sc) {
    return Stack(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.maximize,
          )
        ],
      ),
      ListView(
        controller: sc,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
            height: 60,
            width: 75,
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 20,
                  child: Text(
                    _name,
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
                    _address,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
            height: 50,
            width: 60,
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                    top: 12,
                    left: 20,
                    child: Icon(Icons.phone, color: constant.COLOR_CONCORDIA)),
                Positioned(
                  top: 16,
                  left: 80,
                  child: Text(
                    _phone,
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
                    bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
            height: 50,
            width: 60,
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                    top: 12,
                    left: 20,
                    child: Icon(Icons.public, color: constant.COLOR_CONCORDIA)),
                Positioned(
                  top: 16,
                  left: 80,
                  child: Text(
                    _website,
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
                    bottom: BorderSide(width: 0.5, color: Colors.grey[300]))),
            height: 50,
            width: 60,
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                Positioned(
                    top: 12,
                    left: 20,
                    child:
                        Icon(Icons.schedule, color: constant.COLOR_CONCORDIA)),
                Positioned(
                  top: 16,
                  left: 80,
                  child: Text(
                    _openClosed,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
              height: 168,
              child: ListView.builder(
                  itemCount: _pictures.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Image(
                        image: NetworkImage(_pictures[index]),
                      ))),
          ButtonTheme(
              height: 48,
              child: RaisedButton(
                onPressed: () => widget.onGetDirectionSelected(),
                color: constant.COLOR_CONCORDIA,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.directions,
                      color: Colors.white,
                    ),
                    Text('  Directions',
                        style: TextStyle(color: Colors.white, fontSize: 20))
                  ],
                ),
              ))
        ],
      )
    ]);
  }

  Future<void> _getBuildingDetails(LatLng latLng) async {
    PlaceCoordinate result = SearchBar.searchResult;
    _name = result.building;
    _address =
        result.gPlaceAddress.substring(0, result.gPlaceAddress.length - 16);
    _pictures = result.gPlacePictures;

    if (result.gPlacePhone != null) {
      _phone = result.gPlacePhone;
    } else {
      _phone = 'Information Not Available';
    }

    if (result.gPlaceWebsite != null) {
      _website = result.gPlaceWebsite;
    } else {
      _website = 'Information Not Available';
    }

    if (result.gPlaceOpenClosed != null) {
      if (result.gPlaceOpenClosed) {
        _openClosed = "Open Now";
      } else {
        _openClosed = "Closed";
      }
    } else {
      _openClosed = 'Information Not Available';
    }
  }
}
