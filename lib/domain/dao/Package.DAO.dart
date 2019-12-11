import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/dao/Historic.DAO.dart';
import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:sqflite/sqflite.dart';

class PackageDAO extends CustomDAO<Package> {
  final String _table = DBConsts.TBL_PACKAGE;

  String getTableName() {
    return this._table;
  }

  static PackageDAO getInstance() {
    return new PackageDAO();
  }

  @override
  Package fromMappedJson(Map<String, dynamic> objJson) {
    Package package = new Package(
        codigo: objJson[DBConsts.CODE],
        descricao: objJson[DBConsts.DESCRIPTION],
        servico: objJson[DBConsts.SERVICE],
        historico: HistoricDAO.getInstance().fromListMappedJson(
            objJson[DBConsts.HISTORICO],
            codPackage: objJson[DBConsts.CODE]));
    return package;
  }

  @override
  Map<String, dynamic> toMap(Package obj) {
    return {
      'codigo': obj.codigo,
      'descricao': obj.descricao,
      'servico': obj.servico,
    };
  }

  @override
  Future<List<Package>> selectAllRows() async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      getTableName(), 
      orderBy: 'descricao ASC');

    return rowListToListObject(rowList);
  }

  Future<Package> selectByCode(String codigo) async {
    Database db = await DBHelper.getInstance.database;
    var resultQuery = await db.query(
      getTableName(), 
      where: "codigo = ?",
      whereArgs: [codigo]);

    return resultQuery.isNotEmpty ? fromMappedJson(resultQuery.first) : null;
  }

  Future<List<Package>> selectAllContains(String filter) async 
  {
    if(filter == null)
      filter = "";

    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      getTableName(), 
      where: "descricao like '%$filter%'",
      //whereArgs: [filter],
      orderBy: 'descricao ASC');

    return rowListToListObject(rowList);
  }  
}
