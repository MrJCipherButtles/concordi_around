import 'dart:io';

import 'package:flutter/services.dart';
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as dart_path;


class DBAdapter {
  static final int _version = 3;
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

      _adapter = new SqfliteAdapter(dbPath, version: _version);
      await _adapter.connect();
      return _adapter;
    }
  }
}