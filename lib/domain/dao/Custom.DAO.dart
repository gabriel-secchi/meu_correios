import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

abstract class CustomDAO<T> {

  String obterNomeTabela();
  Map<String, dynamic> toMap(T obj);
  T mapeiaJsonParaObjeto(Map<String, dynamic> objJson);
  
  Future<int> inserir(T obj) async {
    Database db = await DBHelper.getInstance.database;
    return await db.insert(obterNomeTabela(), toMap(obj));
  }

  inserirLista(List<T> objList) async {
    if(objList == null || objList.length == 0)
      return;

    for(T obj in objList) {
      int result = await inserir(obj);
    }

    return;
  }

  Future<List<T>> obterTodos() async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(obterNomeTabela());
    return mapeiaListaJsonParaListaObj(rowList);
  }

  List<T> mapeiaListaJsonParaListaObj(List<Map<String, dynamic>> rowList) {
    List<T> listObj = new List();
    for(Map<String, dynamic> dynamicObj in rowList) {
      T obj = mapeiaJsonParaObjeto(dynamicObj);
      listObj.add( obj );
    }
    
    return listObj;
  }

}