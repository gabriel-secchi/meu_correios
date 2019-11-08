
import 'package:meu_correios/domain/dao/Custom.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class PackageDAO extends CustomDAO<Package> {
  final String _table = "Package";

  String getTableName() {
    return this._table;
  }

}