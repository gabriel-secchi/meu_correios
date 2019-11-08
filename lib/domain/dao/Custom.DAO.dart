import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/database/interfaces/i_mapper.dart';
import 'package:sqflite/sqflite.dart';

abstract class CustomDAO<T> {

  String getTableName();
  
  Future<int> insert(T obj) async {
    Database db = await DBHelper.getInstance.database;
    return await db.insert(getTableName(), (obj as IMapper).toMap());
  }

}