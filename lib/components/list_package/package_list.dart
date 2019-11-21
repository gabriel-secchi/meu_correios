import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class PackageList extends StatefulWidget  {
  static int PACKAGE_ALL = 1;
  static int PACKAGE_ON_CARRIAGE = 2;
  static int PACKAGE_DELIVERED = 3;

  int packageType;

  PackageList({
    Key key,
    this.packageType
  }) : super(key: key);

  _PackageListState _packageListState;

  @override
  _PackageListState createState() {
    _packageListState = _PackageListState();
    return _packageListState;
  }

  filtrar(String texto) => _packageListState.filtrar(texto);
}

class _PackageListState extends State<PackageList> {
  
  void filtrar(String texto) {
    addAnItem(
      new Package(
        codigo: "aaa: " + texto,
        descricao: "teste gabriel"
      )
    );
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Package> _listPackage = new List();

  @override
  void initState() {
    super.initState();
    _loadItens();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _listPackage.length, 
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem( BuildContext context, int index, Animation<double> animation ) {
    return SlideTransition(
      textDirection: TextDirection.ltr,
      transformHitTests: true,
      position: animation.drive(
        Tween<Offset>(
          begin: Offset(1.0, 1.0),
          end: Offset(0.0, 1.0),
        ),
      ),
      child: new CardItemPackage(package: _listPackage.elementAt(index))
    );
  }

  void addAnItem(Package package) {
      _listPackage.insert(0, package);
      _listKey.currentState.insertItem(0);
  }

  void addItemList(List<Package> listPackage) {
    for(Package package in listPackage){
      addAnItem(package);
    }
  }

  void _loadItens() {
    PackageDAO.getInstance().selectAllRows().then((listPackage) { 
      addItemList(listPackage);
    });
  }

}