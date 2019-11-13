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
    String sql = "CREATE TABLE Historic ( "+
        "codPackage TEXT NOT NULL, " +
        "detalhes TEXT NULL, " +
        "local TEXT NULL"+
        "data DATE NOT NULL"+
        "situacao TEXT NULL"+
      ")";

    await tnx.execute( sql );
  }

}