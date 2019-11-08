import 'package:sqflite/sqflite.dart';

abstract class CustomDAO<T> {

  String tableName();

  Future<void> insert(T obj) async {

    

  }

}