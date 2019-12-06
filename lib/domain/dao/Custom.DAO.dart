import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

abstract class CustomDAO<T> {

  String getTableName();
  Map<String, dynamic> toMap(T obj);
  T fromMappedJson(Map<String, dynamic> objJson);
  
  Future<int> insert(T obj) async {
    Database db = await DBHelper.getInstance.database;
    return await db.insert(getTableName(), toMap(obj));
  }

  insertList(List<T> objList) async {
    if(objList == null || objList.length == 0)
      return;

    for(T obj in objList) {
      int result = await insert(obj);
    }

    return;
  }

  Future<List<T>> selectAllRows() async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(getTableName());
    return rowListToListObject(rowList);
  }

  List<T> rowListToListObject(List<Map<String, dynamic>> rowList) {
    List<T> listObj = new List();
    for(Map<String, dynamic> dynamicObj in rowList) {
      T obj = fromMappedJson(dynamicObj);
      listObj.add( obj );
    }
    
    return listObj;
  }

}