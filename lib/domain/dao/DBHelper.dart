import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/*
  help: 
    https://flutter.dev/docs/cookbook/persistence/sqlite
    http://www.macoratti.net/19/08/flut_accsqlite1.htm
*/

class DBHelper {

  static final _databaseName = 'meu_correios_database.db';
  static final _databaseVersion = 1;
  
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // instancia o db na primeira vez que for acessado
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    //await db.execute();
  }  
}