// Created by Chester Yu
// Created: 20/02/2020
// Last Modified: 20/02/2020
// Class to create building object

class Building{

  String _buildingName;
  String _buildingCode;
  String _buildingDescription;
  String _civicNumber;
  String _streetName;

  Building(String name, String code, String description, String civic, String street){
    _buildingName = name;
    _buildingCode = code;
    _buildingDescription = description;
    _civicNumber = civic;
    _streetName = street;
  }

  String toString(){
    return (_buildingCode + " : " + _buildingName);
  }

  String getbuildingName() {
    return _buildingName;
  }
}