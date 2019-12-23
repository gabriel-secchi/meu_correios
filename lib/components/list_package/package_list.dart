import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/packageAnimatedList.dart';

class PackageList extends StatefulWidget {
  static int TODOS_PACOTES = 1;
  static int PACOTES_EM_TRANSPORTE = 2;
  static int PACOTES_ENTREGUES = 3;

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
