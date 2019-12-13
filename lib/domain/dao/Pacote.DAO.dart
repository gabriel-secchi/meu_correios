import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/dao/Historico.DAO.dart';
import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:sqflite/sqflite.dart';

class PacoteDAO extends CustomDAO<Package> {
  final String _table = DBConsts.TBL_PACOTE;

  String obterNomeTabela() {
    return this._table;
  }

  static PacoteDAO getInstance() {
    return new PacoteDAO();
  }

  @override
  Package mapeiaJsonParaObjeto(Map<String, dynamic> objJson) {
    Package package = new Package(
        codigo: objJson[DBConsts.CODIGO],
        descricao: objJson[DBConsts.DESCRICAO],
        servico: objJson[DBConsts.SERVICO],
        historico: HistoricoDAO.getInstance().mapeiaListaJsonParaListaHistorico(
            objJson[DBConsts.HISTORICO],
            codPackage: objJson[DBConsts.CODIGO]));
    return package;
  }

  @override
  Map<String, dynamic> toMap(Package obj) {
    return {
      DBConsts.CODIGO: obj.codigo,
      DBConsts.DESCRICAO: obj.descricao,
      DBConsts.SERVICO: obj.servico,
    };
  }

  @override
  Future<List<Package>> obterTodos() async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      obterNomeTabela(), 
      orderBy: '${DBConsts.DESCRICAO} ASC');

    return mapeiaListaJsonParaListaObj(rowList);
  }

  Future<Package> selectByCode(String codigo) async {
    Database db = await DBHelper.getInstance.database;
    var resultQuery = await db.query(
      obterNomeTabela(), 
      where: "${DBConsts.CODIGO} = ?",
      whereArgs: [codigo]);

    return resultQuery.isNotEmpty ? mapeiaJsonParaObjeto(resultQuery.first) : null;
  }

  Future<List<Package>> obterTodosPeloFiltro(String filtro) async 
  {
    if(filtro == null)
      filtro = "";

    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      obterNomeTabela(), 
      where: "${DBConsts.DESCRICAO} like '%$filtro%'",
      //whereArgs: [filter],
      orderBy: '${DBConsts.DESCRICAO} ASC');

    return mapeiaListaJsonParaListaObj(rowList);
  }  
}
