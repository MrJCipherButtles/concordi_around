import 'package:concordi_around/models/coordinate.dart';
import 'package:flutter/material.dart';

class SearchMenuSuggestionsManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchMenuSuggestions();
  }
}

class _SearchMenuSuggestions extends State<SearchMenuSuggestionsManager> {
  //TODO: get room list
  final List<RoomCoordinate> _myRoomList = [];
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 8,
        child: Container(
            color: Colors.white,
            child: ListView.separated(
              itemCount: _myRoomList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_myRoomList[index].roomId),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              )
            ));
  }  
}