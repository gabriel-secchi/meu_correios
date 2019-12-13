
import 'package:intl/intl.dart';
import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Historic.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:sqflite/sqflite.dart';

class HistoricoDAO extends CustomDAO<Historic> {
  final String _tabela = DBConsts.TBL_HISTORICO;

  String obterNomeTabela() {
    return this._tabela;
  }

  static HistoricoDAO getInstance() {
    return new HistoricoDAO();
  }

  @override
  Historic mapeiaJsonParaObjeto(Map<String, dynamic> objJson) {

    String _dataStr = objJson[DBConsts.DATA];
    DateTime _data = DateTime.now();
    if( _dataStr.isNotEmpty ) {
      if(_dataStr.contains("/"))
        _data = new DateFormat(DBConsts.FORMATO_DATA_BR).parse(_dataStr);
      else
        _data = new DateFormat(DBConsts.FORMATO_DATA_DB).parse(_dataStr);
    }

    Historic _pacote = new Historic(
      codPackage: objJson[DBConsts.COD_PACOTE],
      detalhes: objJson[DBConsts.DETALHES],
      local: objJson[DBConsts.LOCAL],
      data: _data,
      situacao: objJson[DBConsts.SITUACAO],
    );

    return _pacote;
  }

  List<Historic> mapeiaListaJsonParaListaHistorico(List<dynamic> listMapJson, {String codPackage = null}) {
    List<Historic> objList = new List();
    if(listMapJson == null)
      return objList;

    for(Map<String, dynamic> dynamicObj in listMapJson) {
      Historic obj = mapeiaJsonParaObjeto(dynamicObj);
      if(codPackage != null)
        obj.codPackage = codPackage;

      objList.add( obj );
    }
    return objList;
  }

  @override
  Map<String, dynamic> toMap(Historic obj) {
     return {
      DBConsts.COD_PACOTE: obj.codPackage,
      DBConsts.DETALHES: obj.detalhes,
      DBConsts.LOCAL: obj.local,
      DBConsts.DATA: new DateFormat(DBConsts.FORMATO_DATA_DB).format(obj.data),
      DBConsts.SITUACAO: obj.situacao,
    };
  }

  Future<List<Historic>> listarTodosDoPacote(String codPacote) async {
    Database db = await DBHelper.getInstance.database;
    List<Map<String, dynamic>> rowList = await db.query(
      obterNomeTabela(),
      where: '${DBConsts.COD_PACOTE} = ?',
      whereArgs: [codPacote],
      orderBy: '${DBConsts.SITUACAO} DESC'
    );

    return mapeiaListaJsonParaListaObj(rowList);
  }

  Future<int> deletarTodosDoPacote(String codPacote) async {
    Database db = await DBHelper.getInstance.database;
    return await db.delete(
      obterNomeTabela(), 
      where: '${DBConsts.COD_PACOTE} = ?',
      whereArgs: [codPacote]
    );
  }

  inserirNoPacote(List<Historic> listaObj, Package pacote) async {
    for(Historic obj in listaObj) {
      obj.codPackage = pacote.codigo;
      this.inserir(obj);
    }
  }

}