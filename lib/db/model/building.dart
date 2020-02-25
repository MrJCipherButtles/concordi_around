import 'dart:async';
import 'package:jaguar_query/jaguar_query.dart';
import 'package:jaguar_orm/jaguar_orm.dart';
// import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';

part 'building.jorm.dart';

// The model
class Building {
  Building();

  Building.make(this.id, this.name);

  @PrimaryKey(auto:true)
  int id;

  @Column(isNullable: false)
  String name;

 
  String toString() =>
      'Building(id: $id, name: $name)';
}

@GenBean()
class BuildingBean extends Bean<Building> with _BuildingBean {
  BuildingBean(Adapter adapter) : super(adapter);


  final String tableName = 'buildings';
}