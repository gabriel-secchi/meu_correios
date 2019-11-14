
import 'package:intl/intl.dart';
import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Historic.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:sqflite/sqflite.dart';

class HistoricDAO extends CustomDAO<Historic> {
  final String _table = "Historic";

  String getTableName() {
    return this._table;
  }

  static HistoricDAO getInstance() {
    return new HistoricDAO();
  }

  @override
  Historic fromMappedJson(Map<String, dynamic> objJson) {

    String _strDate = objJson['data'];
    DateTime _date = DateTime.now();
    if( _strDate.isNotEmpty ) {
      if(_strDate.contains("/"))
        _date = new DateFormat("dd/MM/yyyy hh:mm").parse(_strDate);
      else
        _date = new DateFormat("yyyMMddhhmmss").parse(_strDate);
    }

    Historic package = new Historic(
      codPackage: objJson['codPackage'],
      detalhes: objJson['detalhes'],
      local: objJson['local'],
      //data: new DateFormat("dd/MM/yyyy hh:mm").parse(objJson['data']),
      data: _date,
      situacao: objJson['situacao'],
    );

    return package;
  }

  List<Historic> fromListMappedJson(List<dynamic> listMapJson, {String codPackage = null}) {
    List<Historic> objList = new List();
    if(listMapJson == null)
      return objList;

    for(Map<String, dynamic> dynamicObj in listMapJson) {
      Historic obj = fromMappedJson(dynamicObj);
      if(codPackage != null)
        obj.codPackage = codPackage;

      objList.add( obj );
    }
    return objList;
  }

  @override
  Map<String, dynamic> toMap(Historic obj) {
     return {
      'codPackage': obj.codPackage,
      'detalhes': obj.detalhes,
      'local': obj.local,
      'data': new DateFormat("yyyMMddhhmmss").format(obj.data),
      'situacao': obj.situacao,
    };
  }

  Future<List<Historic>> listAllOfThePackage(String codPackage) async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      getTableName(),
      where: 'codPackage = ?',
      whereArgs: [codPackage],
      orderBy: 'situacao DESC'
    );

    return rowListToListObject(rowList);
  }

  Future<int> deleteAllOfThePackage(String codPackage) async {
    Database db = await DBHelper.getInstance.database;
    return await db.delete(
      getTableName(), 
      where: 'codPackage = ?',
      whereArgs: [codPackage]
    );
  }

  insertOnPackage(List<Historic> listaObj, Package pacote) async {
    for(Historic obj in listaObj) {
      obj.codPackage = pacote.codigo;
      this.insert(obj);
    }
  }

}