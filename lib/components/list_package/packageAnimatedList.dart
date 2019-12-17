import 'package:flutter/material.dart';
import 'package:meu_correios/components/list_package/baseAnimatedList.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/domain/dao/Pacote.DAO.dart';
import 'package:meu_correios/domain/models/Pacote.dart';

class PackageAnimatedList extends BaseAnimatedList<Pacote> {
  
  @override
  Widget buildCardItem(Pacote item) {
    return new CardItemPackage(pacote: item);
  }

  @override
  Iterable<Pacote> itemContains(List<Pacote> listaPacotes, Pacote pacote) {
    return listaPacotes.where((i) => pacote.descricao == i.descricao);
  }

  void filtrar(String strFiltro) {
    PacoteDAO.getInstance()
      .obterTodosPeloFiltro(strFiltro)
      .then((pacotesFiltrados) => rebuildListItems(pacotesFiltrados));
  }

  void loadItens() {
    PacoteDAO.getInstance()
      .obterTodos()
      .then((listaPacotes) => addItemList(listaPacotes));
  }
  
}
