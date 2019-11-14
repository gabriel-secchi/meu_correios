
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:meu_correios/domain/database/MigrationExecutor.dart';
import 'package:sqflite/sqflite.dart';

abstract class Migration {
  Database db;

  Migration(
    @required this.db
  );

  String migrationName();
  run(DatabaseExecutor tnx);

  migrate() async {

    String migrationName = this.migrationName();
    
    int count = Sqflite.firstIntValue(
      await this.db.rawQuery( 
        'SELECT COUNT(1) ' +
        'FROM ${MigrationExecutor.TABLE_NAME} '
        "WHERE migration = '${migrationName}'"
      )
    );

    if( count > 0)
      return; //Add Trow exception

    await db.transaction((tnx) async {
      await run(tnx);

      await tnx.insert(
        MigrationExecutor.TABLE_NAME, 
        {
          'migration': migrationName, 
          //'run_date': DateFormat('dd/MM/yyyy hh:mm').format(DateTime.now())
          'run_date': DateFormat('yyyMMddhhmmss').format(DateTime.now())
        }
      );
    });

  }

}