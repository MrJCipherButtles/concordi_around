import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as dart_path;


class DBAdapter {
  static final int _version = 2;
  SqfliteAdapter _adapter;


  Future<SqfliteAdapter> getAdapter() async {
    if (_adapter != null) {
      return _adapter;
    }
    else {
      Directory directory = await getApplicationDocumentsDirectory();
      var dbPath = dart_path.join(directory.path, "naima.db");
      if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
        ByteData data = await rootBundle.load("assets/naima.db");
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(dbPath).writeAsBytes(bytes);
      }



//      var exists = await databaseExists(dbFilePath);
//      print("*********** EXISTS $exists");
//      print(dbFilePath == "/data/data/ca.concordia.w20.soen390.concordi_around/databases/naima.db");


//      if (!exists) {
//        // Should happen only the first time you launch your application
//        print("Creating new copy from asset");
//
//        // Make sure the parent directory exists
//        try {
//          await Directory(path.dirname(dbFilePath)).create(recursive: true);
//        } catch (_) {}
//
//        // Copy from asset
//        ByteData data = await rootBundle.load(path.join("assets", "naima.db"));
//        List<int> bytes =
//        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//
//        // Write and flush the bytes written
//        await File(dbPath).writeAsBytes(bytes, flush: true);
//
//      } else {
//        print("Opening existing database");
//      }

      _adapter = new SqfliteAdapter(dbPath, version: _version);
      await _adapter.connect();
      return _adapter;
    }
  }
}