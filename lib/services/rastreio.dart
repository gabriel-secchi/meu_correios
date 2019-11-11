import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';
import 'package:meu_correios/services/customSnackBar.dart';

class Rastreio {

  static final String urlRastreio = "https://api.postmon.com.br/v1/rastreio/ect/";
  
  static rastrearUm( final BuildContext context, final String codRastreio ) async {

    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.black45,
        content: Center(
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.grey
          )
        )
      )
    );
  
    final response = await http.get( Rastreio.urlRastreio + codRastreio );

    scaffold.deactivate();

    if (response.statusCode == 200) { 
      var objResponse = json.decode(response.body);
      Package package = Package.newInstace().fromMappedJson(objResponse);
      PackageDAO().insert(package);
      
      CustomSnackBar.showSuccess(context, "Pacote adicionado com sucesso");

    } else {
      CustomSnackBar.showError(context, "Código de rastreio não localizado");
    }
  }

}