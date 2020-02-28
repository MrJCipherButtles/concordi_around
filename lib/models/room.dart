// Created by Chester Yu
// Created: 20/02/2020
// Last Modified: 20/02/2020
// Class to create building object

class Room{

  String _room;

  Room(String name){
    _room = name;
  }

  String toString(){
    return ("Room" + " : " + _room);
  }
}