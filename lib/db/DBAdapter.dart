import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBAdapter {
  static final int _version = 2;
  SqfliteAdapter _adapter;


  Future<SqfliteAdapter> getAdapter() async {
    if (_adapter != null) {
      return _adapter;
    }
    else {
      var dbPath = await getDatabasesPath();
      _adapter = new SqfliteAdapter(path.join(dbPath, "goomba.db"), version: _version);
      await _adapter.connect();
      return _adapter;
    }
  }
}