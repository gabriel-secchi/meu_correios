import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/baseAnimatedList.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/domain/dao/Pacote.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class PackageAnimatedList extends BaseAnimatedList<Package> {
  
  @override
  Widget buildCardItem(Package item) {
    return new CardItemPackage(package: item);
  }

  @override
  Iterable<Package> itemContains(List<Package> listItem, Package item) {
    return listItem.where((i) => item.descricao == i.descricao);
  }

  void filtrar(String textFilter) {
    PacoteDAO.getInstance()
      .obterTodosPeloFiltro(textFilter)
      .then((filtrados) => rebuildListItems(filtrados));
  }

  void loadItens() {
    PacoteDAO.getInstance()
      .obterTodos()
      .then((listPackage) => addItemList(listPackage));
  }
  
}
