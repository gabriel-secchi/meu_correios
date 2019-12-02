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
  deleteUm() => _packageListState._removeAnIten(0);
}

class _PackageListState extends State<PackageList> {
  
  final int _timeAnimation = 250;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Package> _listPackageMain = new List();

  @override
  void initState() {
    super.initState();
    _loadItens();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: 0, //_listPackage == null ? 0 :_listPackage.length,
      itemBuilder: (ctx, index, animation) => _buildItem(ctx, _listPackageMain.elementAt(index), animation),
    );
  }

  Widget _buildItem( BuildContext context, Package item, Animation<double> animation ) {
    return SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: SizedBox(
          child: new CardItemPackage(package: item)
        ),
      );
  }

  void filtrar(String texto) {
    PackageDAO.getInstance().selectAllRows().then((listPackage) {
      //setState(() {

        List<Package> filtrados = listPackage.where(
              (i) => i.descricao.contains(texto)
        ).toList();

        List<int> positionToDelete = new List();
        for(Package item in _listPackageMain) {
          var finder = filtrados.where((i) => item.descricao.contains(i.descricao));
          
          if(finder != null && finder.length > 0)
            continue;
                      
          positionToDelete.add(_listPackageMain.indexOf(item));
        }

        positionToDelete.sort((b, a) => a.compareTo(b));

        for (int pos in positionToDelete) {
          _removeAnIten(pos);
        }

        for(Package item in filtrados) {
          //if(_listPackageMain.contains(item))
          var finder = _listPackageMain.where((i) => item.descricao.contains(i.descricao));
          
          if(finder != null && finder.length > 0)
            continue;

          addAnItem(item);
        }
        
      });

  }

  void addAnItem(Package package, {int order: 0}) {
      _listPackageMain.insert(order, package);
      _listKey.currentState.insertItem(order, duration: Duration(milliseconds: _timeAnimation));
  }

  void addItemList(List<Package> listPackage) {
    for(Package package in listPackage) {
      addAnItem(package);
    }
  }

  void _loadItens() {
    PackageDAO.getInstance().selectAllRows().then((listPackage) { 
      addItemList(listPackage);
    });
  }

  void _removeAnIten(int position) {

    Package itemToRemove = _listPackageMain.elementAt(position);

    _listKey.currentState.removeItem(
      position, 
      (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
      duration: Duration(milliseconds: _timeAnimation)
    );

    _listPackageMain.removeAt(position);
  }

  

}