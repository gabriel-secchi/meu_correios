import 'package:flutter/material.dart';

abstract class BaseAnimatedList<T> {
  final int _timeAnimation = 250;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<T> _listItems = new List();

  Widget buildCardItem(T item);
  Iterable<T> itemContains(List<T> listItem, T item);
    
  Widget build() {
    return AnimatedList(
      key: _listKey,
      initialItemCount: 0,
      itemBuilder: (ctx, index, animation) => _buildItem(ctx, _listItems.elementAt(index), animation),
    );
  }

  Widget _buildItem(BuildContext context, T item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: SizedBox(child: buildCardItem(item)),
    );
  }

  void _addAnItem(T item, {int order: 0}) {
    _listItems.insert(order, item);
    _listKey.currentState
        .insertItem(order, duration: Duration(milliseconds: _timeAnimation));
  }

  void addItemList(List<T> listItem) 
  {
    int count = 0;
    for (T item in listItem) 
    {
      var finder = itemContains(_listItems, item);

      if (finder != null && finder.length > 0) {
        count++;
        continue;
      }

      _addAnItem(item, order: count);
      count++;
    }
  }

  void _removeAnIten(int position) {
    T itemToRemove = _listItems.elementAt(position);

    _listKey.currentState.removeItem(
      position,
      (BuildContext context, Animation<double> animation) => _buildItem(context, itemToRemove, animation),
      duration: Duration(milliseconds: _timeAnimation)
    );

    _listItems.removeAt(position);
  }

  void rebuildListItems(List<T> newListItems) 
  {
    List<int> positionToDelete = new List();
    for (T item in _listItems) {
      var finder = itemContains(newListItems, item);

      if (finder != null && finder.length > 0) 
        continue;

      positionToDelete.add(_listItems.indexOf(item));
    }

    //Ordena decrescente para apagar os registros mais altos da lista primeiro
    positionToDelete.sort((b, a) => a.compareTo(b));
    for (int pos in positionToDelete) {
      _removeAnIten(pos);
    }

    addItemList(newListItems);
  }
}