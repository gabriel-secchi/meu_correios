import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meu_correios/domain/models/Pacote.dart';
import 'package:meu_correios/domain/dao/Pacote.DAO.dart';
import 'package:meu_correios/services/customLoading.dart';

class Rastreio {

  static final String urlRastreio = "https://api.postmon.com.br/v1/rastreio/ect/";
  BuildContext _context;

  Rastreio(this._context);
  
  Future<bool> rastrearUm( String codPackage, onSuccessTracking ) async {
    try {

      final response = await CustomLoading(this._context).show(() {
        return http.get( Rastreio.urlRastreio + codPackage );
      });

      if (response.statusCode == 200) { 
        var objResponse = json.decode(response.body);
        Pacote objTracking = PacoteDAO.getInstance().mapeiaJsonParaObjeto(objResponse);
        await onSuccessTracking(objTracking);
        return true;
      }

      throw("Objeto não encontrado");
    }
    catch(error) {
      throw("Código de rastreio não localizado");
    }
    
  }

}