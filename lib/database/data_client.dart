import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataClient {
  final String _databaseName = "Quran.db";

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    log('db == null => ${_database == null}');
    // lazily instantiate the db the first time it is accessed
    await initDatabase();
    _database = await _openDatabase(_databaseName);
    log('db == null => ${_database == null}');
    return _database;
  }

  Future _openDatabase(String fileName) async {
    String databasePath = await getDatabasesPath();
    var path = join(databasePath, fileName);
    return openDatabase(path, version: 3);
  }

  Future initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    bool exists = await databaseExists(path);
    if (!exists) {
      log("Creating new copy of DataBase from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets/data", _databaseName));
      List<int> bytes =
          data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      log("Opening existing database");
    }
  }
}
