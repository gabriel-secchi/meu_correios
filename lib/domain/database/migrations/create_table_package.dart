

import 'package:meu_correios/domain/database/migrations/Migration.dart';
import 'package:sqflite/sqlite_api.dart';

class CreateTablePackage extends Migration {
  CreateTablePackage(Database db) : super(db);

  @override
  String migrationName() {
    return 'create_table_package_2019_10_13_14:00:00';
  }

  @override
  run(DatabaseExecutor tnx) async {
    String sql = "CREATE TABLE Package (codigo TEXT NOT NULL, descricao TEXT NOT NULL, servico TEXT NULL)";
    await tnx.execute( sql );
  }  
    
}