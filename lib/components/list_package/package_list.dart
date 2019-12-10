import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/components/list_package/packageAnimatedList.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class PackageList extends StatefulWidget {
  static int PACKAGE_ALL = 1;
  static int PACKAGE_ON_CARRIAGE = 2;
  static int PACKAGE_DELIVERED = 3;

  int packageType;

  PackageList({Key key, this.packageType}) : super(key: key);

  _PackageListState _packageListState;

  @override
  _PackageListState createState() {
    _packageListState = _PackageListState();
    return _packageListState;
  }

  filtrar(String texto) => _packageListState.filtrar(texto);
}

class _PackageListState extends State<PackageList> with AutomaticKeepAliveClientMixin<PackageList> 
{
  @override
  bool get wantKeepAlive => true;

  PackageAnimatedList packageAnimatedList = new PackageAnimatedList();

  @override
  void initState() {
    super.initState();
    packageAnimatedList.loadItens();
  }

  @override
  Widget build(BuildContext context) {
    return packageAnimatedList.build();
  }

  void filtrar(String textFilter) {
    packageAnimatedList.filtrar(textFilter);
  }
}
