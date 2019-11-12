
import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Historic.dart';
import 'package:sqflite/sqflite.dart';

class HistoricDAO extends CustomDAO<Historic> {
  final String _table = "Historic";

  String getTableName() {
    return this._table;
  }

  static CustomDAO getInstance() {
    return new HistoricDAO();
  }

  @override
  Historic fromMappedJson(Map<String, dynamic> objJson) {
    Historic package = new Historic(
      codPackage: objJson['codPackage'],
      detalhes: objJson['detalhes'],
      local: objJson['local'],
      data: objJson['data'],
      situacao: objJson['situacao'],
    );
    return package;
  }

  @override
  Map<String, dynamic> toMap(Historic obj) {
     return {
      'codPackage': obj.codPackage,
      'detalhes': obj.detalhes,
      'local': obj.local,
      'data': obj.data,
      'situacao': obj.situacao,
    };
  }

  Future<List<Historic>> listAllOfThePackage(String codPackage) async {
    Database db = await DBHelper.getInstance.database;
    /*Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      getTableName(),
      where: 'codPackage = ?',
      whereArgs: [codPackage],
      orderBy: 'situacao DESC'
    );

    return rowListToListObject(rowList);
    */
    var customQuery = () => db.query(
      getTableName(),
      where: 'codPackage = ?',
      whereArgs: [codPackage],
      orderBy: 'situacao DESC'
    );

    return await selectAllRowsOnQuery( customQuery );
  }


}