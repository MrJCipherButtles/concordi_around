import 'package:flutter/material.dart';
import './room.dart';

class SearchMenuSuggestionsManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchMenuSuggestions();
  }
}

class _SearchMenuSuggestions extends State<SearchMenuSuggestionsManager> {
  final List<Room> _myRoomList = new List<Room>();
  @override
  Widget build(BuildContext context) {
     _createRoomList();
    return Expanded(
        flex: 8,
        child: Container(
            color: Colors.white,
            child: ListView.separated(
              itemCount: _myRoomList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_myRoomList[index].toString(),),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              )
            ));
  }
  void _createRoomList() {
    _myRoomList.clear();
    _myRoomList.add(new Room("H-830"));
    _myRoomList.add(new Room("H-820"));
    _myRoomList.add(new Room("H-835"));
  }
  
}