import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class PackageList extends StatefulWidget  {
  static int PACKAGE_ALL = 1;

  int packageType;
  PackageList({
    Key key,
    this.packageType
  }) : super(key: key);

  @override
  _PackageListState createState() => _PackageListState();

}

class _PackageListState extends State<PackageList> {
  //final int packageType;
  Package _selectedItem;
  ListModel<Package> _list = new ListModel();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  //_PackageListState(this.packageType);

  @override
  void initState() {
    super.initState();
    if(widget.packageType == PackageList.PACKAGE_ALL) {
      PackageDAO.getInstance().selectAllRows().then((listPackage) { 
        setState(() {
          //_list = listPackage;
          _list = ListModel<Package>(
            listKey: _listKey,
            initialItems: listPackage,
            removedItemBuilder: _buildRemovedItem
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AnimatedList(
        key: _listKey,
        initialItemCount: _list == null ? 0 : _list.length,
        itemBuilder: _buildItem,
      ),
    );
  }

  Widget _buildItem( BuildContext context, int index, Animation<double> animation ) {
    return CardItemPackage(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  Widget _buildRemovedItem(Package item, BuildContext context, Animation<double> animation) {
    return CardItemPackage(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    List<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}