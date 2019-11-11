import 'package:flutter/material.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:meu_correios/services/rastreio.dart';

class AddPackage {

  static dialog(BuildContext context) async {
    
    TextEditingController _tfDescricaoController = TextEditingController();
    TextEditingController _tfCodigoController = TextEditingController();

    return showDialog(
      context: context,
      builder: (contextDialog) {
        return AlertDialog(
          title: Text('Adicionar Encomenda'),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _tfDescricaoController,
                decoration: InputDecoration(hintText: "Descrição do pacote"),
                autofocus: true,
              ),
              TextField(
                controller: _tfCodigoController,
                decoration: InputDecoration(hintText: "Código de rastreio"),
                autofocus: true,
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancelar'),
              onPressed: () {
                Navigator.of(contextDialog).pop();
              },
            ),
            new FlatButton(
              child: new Text('Adicionar'),
              onPressed: () {
                Navigator.of(contextDialog).pop();
                Rastreio.rastrearUm(context, _tfCodigoController.text)
                  .then((package) {
                    package.descricao = _tfDescricaoController.text;
                    PackageDAO().insert(package);
                  });
              },
            )
          ],
        );
      }
    );
  }

}