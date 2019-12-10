import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/packageAnimatedList.dart';

class PackageList2 extends StatefulWidget {
  static int PACKAGE_ALL = 1;
  static int PACKAGE_ON_CARRIAGE = 2;
  static int PACKAGE_DELIVERED = 3;

  int packageType;

  PackageList2({Key key, this.packageType}) : super(key: key);

  _PackageListState2 _packageListState;

  @override
  _PackageListState2 createState() {
    _packageListState = _PackageListState2();
    return _packageListState;
  }

  filtrar(String texto) => _packageListState.filtrar(texto);
}

class _PackageListState2 extends State<PackageList2> with AutomaticKeepAliveClientMixin<PackageList2> 
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
