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
      itemBuilder: _buildItem,
    );
  }

  Widget _buildItem( BuildContext context, int index, Animation<double> animation ) {
    return FadeTransition(
      opacity: animation.drive(
        Tween<double>(
          begin: 0,
          end: 1,
        ),
      ),
      child: new CardItemPackage(package: _listPackageMain.elementAt(index)),
        
    );

    
  }

  void filtrar(String texto) {
    PackageDAO.getInstance().selectAllRows().then((listPackage) {
      //setState(() {

        List<Package> filtrados = listPackage.where(
              (i) => i.descricao.contains(texto)
        ).toList();

        // _removeAllItems();
        // addItemList(filtrados);
        // _listPackageMain = filtrados;

        for(Package item in _listPackageMain) {
          if(filtrados.contains(item)) {
            String teste = "aaa";
            String asd = "teste";
            continue;
          }

          _removeAnIten(_listPackageMain.indexOf(item));
        }

        for(Package item in filtrados) {
          if(_listPackageMain.contains(item))
            continue;

          addAnItem(item);
        }
        
        // if(texto.isEmpty)
        //   addItemList(listPackage);
        // else {
        //   addItemList(
        //     listPackage.where(
        //       (i) => i.descricao.contains(texto)
        //     ).toList()
        //   );
        // }
      });

    //});

    /*setState(() {
      _listPackage = _listPackage.where(
        (i) => i.descricao.contains(texto)
      ).toList();

      String asd = "asd";
    });*/
  }

  void addAnItem(Package package) {
      _listPackageMain.insert(0, package);
      _listKey.currentState.insertItem(0, duration: Duration(milliseconds: 500));
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
    _listPackageMain.removeAt(position);
    _listKey.currentState.removeItem(
      position, 
      (BuildContext context, Animation<double> animation) => _buildItem(context, 0, animation), 
      duration: const Duration(milliseconds: 500)
    );
  }

  void _removeAllItems() {
    final int itemCount = _listPackageMain.length;
  
      for (var i = 0; i < itemCount; i++) {
        //Package itemToRemove = _listPackage.elementAt(0);
        _listKey.currentState.removeItem(0,
          (BuildContext context, Animation<double> animation) => _buildItem(context, 0, animation),
          duration: const Duration(milliseconds: 250),
        );
  
        _listPackageMain.removeAt(0);
      }
  }

}