import 'package:flutter/cupertino.dart';
import 'package:meu_correios/domain/database/migrations/create_table_historic.dart';
import 'package:meu_correios/domain/database/migrations/create_table_package.dart';
import 'package:sqflite/sqflite.dart';

class MigrationExecutor {
  static String TABLE_NAME = 'Migrations';
  final String _TABLE = TABLE_NAME;
  Database db;

  MigrationExecutor({
    @required this.db
  });

  _createMigrationTable() async {
    String sql = 'CREATE TABLE IF NOT EXISTS ${this._TABLE} (migration TEXT NOT NULL PRIMARY KEY, run_date DATE NOT NULL)';
    await this.db.execute(sql);
  }

  execute() {
    _createMigrationTable();

    CreateTablePackage(this.db).migrate();
    CreateTableHistoric(this.db).migrate();
  }

}