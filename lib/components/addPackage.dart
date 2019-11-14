import 'package:flutter/material.dart';
import 'package:meu_correios/domain/dao/Historic.DAO.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:meu_correios/services/customSnackBar.dart';
import 'package:meu_correios/services/rastreio.dart';

class DialogAddPackage {

  BuildContext _context;
  Package _addPackage;

  DialogAddPackage(this._context);

  open() async {
    
    TextEditingController _tfDescricaoController = TextEditingController();
    TextEditingController _tfCodigoController = TextEditingController();

    return showDialog(
      context: this._context,
      builder: (contextDialog) {
        return AlertDialog(
          title: Text('Adicionar Encomenda'),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: TextField(
                  controller: _tfDescricaoController,
                  decoration: InputDecoration(hintText: "Descrição do pacote"),
                  autofocus: true,
                ),
              ),
              TextField(
                controller: _tfCodigoController,
                decoration: InputDecoration(hintText: "Código de rastreio"),
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

                this._addPackage = Package(
                    descricao: _tfDescricaoController.text,
                    codigo: _tfCodigoController.text
                );

                _trackAndSavePackage();

              },
            )
          ],
        );
      }
    );
  }

  _trackAndSavePackage() {
    Rastreio(this._context).rastrearUm(
        this._addPackage.codigo,
        _onSuccessTracking
      )
      .catchError((error) => CustomSnackBar.showError(this._context, error) );
  }

  _onSuccessTracking(Package objTracking) async {
    objTracking.descricao = this._addPackage.descricao;
    this._addPackage = objTracking;
    this._saveTrackedPackage();
  }

  _saveTrackedPackage() {
    PackageDAO.getInstance().insert(this._addPackage);
    HistoricDAO.getInstance().insertList(this._addPackage.historico);
    CustomSnackBar.showSuccess(this._context, "Pacote adicionado com sucesso");
  }
  
}