

import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/migrations/Migration.dart';
import 'package:sqflite/sqlite_api.dart';

class CreateTablePackage extends Migration {
  CreateTablePackage(Database db) : super(db);

  @override
  String migrationName() {
    return 'create_table_package_2019_10_13_14:00:00';
  }

  @override
  run(DatabaseExecutor tnx) async 
  {
    String sql = 
    "CREATE TABLE ${DBConsts.TBL_PACOTE} ( " +
    "   ${DBConsts.CODIGO} TEXT NOT NULL, " +
    "   ${DBConsts.DESCRICAO} TEXT NOT NULL, " +
    "   ${DBConsts.SERVICO} TEXT NULL, " +
    "   ${DBConsts.STATUS} INT NULL, " +
    "   ${DBConsts.ARQUIVADO} INT DEFAULT 0 " +
    ")";
    await tnx.execute( sql );
  }  
    
}