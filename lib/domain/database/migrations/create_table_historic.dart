import 'package:meu_correios/domain/database/DBConsts.dart';
import 'package:meu_correios/domain/database/migrations/Migration.dart';
import 'package:sqflite/sqlite_api.dart';

class CreateTableHistoric extends Migration {
  CreateTableHistoric(Database db) : super(db);

  @override
  String migrationName() {
    return 'create_table_historic_2019_10_13_14:00:00';
  }

  @override
  run(DatabaseExecutor tnx) async {
    String sql = 
    "CREATE TABLE ${DBConsts.TBL_HISTORIC} ( " +
    "   ${DBConsts.CODE_PACKAGE} TEXT NOT NULL, " +
    "   ${DBConsts.DETAILS} TEXT NULL, " +
    "   ${DBConsts.LOCATION} TEXT NULL, " +
    "   ${DBConsts.DATE} INT NOT NULL, " +
    "   ${DBConsts.SITUATION} TEXT NULL " +
    ")";

    await tnx.execute( sql );
  }

}