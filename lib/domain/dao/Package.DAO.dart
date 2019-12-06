import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/dao/Historic.DAO.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:sqflite/sqflite.dart';

class PackageDAO extends CustomDAO<Package> {
  final String _table = "Package";

  String getTableName() {
    return this._table;
  }

  static PackageDAO getInstance() {
    return new PackageDAO();
  }

  @override
  Package fromMappedJson(Map<String, dynamic> objJson) {
    Package package = new Package(
        codigo: objJson['codigo'],
        descricao: objJson['descricao'],
        servico: objJson['servico'],
        historico: HistoricDAO.getInstance().fromListMappedJson(
            objJson['historico'],
            codPackage: objJson['codigo']));
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
