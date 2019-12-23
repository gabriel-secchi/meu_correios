
import 'package:intl/intl.dart';
import 'package:meu_correios/Consts.dart';
import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/DBHelper.dart';
import 'package:meu_correios/domain/models/Historico.dart';
import 'package:meu_correios/domain/models/Pacote.dart';
import 'package:sqflite/sqflite.dart';

class HistoricoDAO extends CustomDAO<Historico> {
  final String _tabela = DBConsts.TBL_HISTORICO;

  String obterNomeTabela() {
    return this._tabela;
  }

  static HistoricoDAO getInstance() {
    return new HistoricoDAO();
  }

  @override
  Historico mapeiaJsonParaObjeto(Map<String, dynamic> objJson) {

    String _dataStr = objJson[DBConsts.DATA];
    DateTime _data = DateTime.now();
    if( _dataStr.isNotEmpty ) {
      if(_dataStr.contains("/"))
        _data = new DateFormat(DBConsts.FORMATO_DATA_BR).parse(_dataStr);
      else
        _data = new DateFormat(DBConsts.FORMATO_DATA_DB).parse(_dataStr);
    }

    Historico _historico = new Historico(
      codPacote: objJson[DBConsts.COD_PACOTE],
      detalhes: objJson[DBConsts.DETALHES],
      local: objJson[DBConsts.LOCAL],
      data: _data,
      situacao: objJson[DBConsts.SITUACAO],
    );

    return _historico;
  }

  List<Historico> mapeiaListaJsonParaListaHistorico(List<dynamic> listMapJson, {String codPackage = null}) {
    List<Historico> objList = new List();
    if(listMapJson == null)
      return objList;

    for(Map<String, dynamic> dynamicObj in listMapJson) {
      Historico obj = mapeiaJsonParaObjeto(dynamicObj);
      if(codPackage != null)
        obj.codPacote = codPackage;

      objList.add( obj );
    }
    return objList;
  }

  @override
  Map<String, dynamic> toMap(Historico obj) {
     return {
      DBConsts.COD_PACOTE: obj.codPacote,
      DBConsts.DETALHES: obj.detalhes,
      DBConsts.LOCAL: obj.local,
      DBConsts.DATA: new DateFormat(DBConsts.FORMATO_DATA_DB).format(obj.data),
      DBConsts.SITUACAO: obj.situacao,
    };
  }

  Future<List<Historico>> listarTodosDoPacote(String codPacote) async {
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

  inserirNoPacote(List<Historico> listaObj, Pacote pacote) async {
    for(Historico obj in listaObj) {
      obj.codPacote = pacote.codigo;
      this.inserir(obj);
    }
  }

  obterStatus(List<Historico> listaObj) {
    if( listaObj == null || listaObj.length == 0 )
      return Consts.PACOTE_AGUARDANDO_POSTAGEM;
    
    bool isEntregue = listaObj.any((i) => i.situacao == "Objeto entregue ao destinatário");
    if(isEntregue)
      return Consts.PACOTE_ENTREGUE;

    return Consts.PACOTE_EM_TRANSPORTE;
  }
}