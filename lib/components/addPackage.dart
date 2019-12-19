import 'package:flutter/material.dart';
import 'package:meu_correios/domain/dao/Historico.DAO.dart';
import 'package:meu_correios/domain/dao/Pacote.DAO.dart';
import 'package:meu_correios/domain/models/Pacote.dart';
import 'package:meu_correios/services/customSnackBar.dart';
import 'package:meu_correios/services/rastreio.dart';

class DialogAddPackage {

  BuildContext _context;
  Pacote _addPackage;
  var _successCallback;

  DialogAddPackage(this._context);

  open({successcallback = false}) async {
    this._successCallback = successcallback;

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

                this._addPackage = Pacote(
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
    PacoteDAO.getInstance().selectByCode(this._addPackage.codigo).then((package) {
      if(package == null) {
        Rastreio(this._context).rastrearUm(
          this._addPackage.codigo,
          _onSuccessTracking
        )
        .catchError((error) => CustomSnackBar.showError(this._context, error) );
      }
      else {
        CustomSnackBar.showError(this._context, "Código de rastreio já cadastrado");
      }
    });
  }

  _onSuccessTracking(Pacote objTracking) async {
    objTracking.descricao = this._addPackage.descricao;
    this._addPackage = objTracking;

    this._saveTrackedPackage();

    if(this._successCallback  != false)
      this._successCallback();
  }

  _saveTrackedPackage() {
    PacoteDAO.getInstance().inserir(this._addPackage);
    HistoricoDAO.getInstance().inserirLista(this._addPackage.historico);
    CustomSnackBar.showSuccess(this._context, "Pacote adicionado com sucesso");
  }
  
}