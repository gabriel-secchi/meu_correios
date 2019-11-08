import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

class Rastreio {

  static final String urlRastreio = "https://api.postmon.com.br/v1/rastreio/ect/";
  
  static rastrearUm(String codRastreio) async {
    String asd = "JN252931930BR";
    final response = await http.get( Rastreio.urlRastreio + asd );

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      var asd = json.decode(response.body);
      var ggg = "asd";
      Package sss = new Package();
      sss.codigo = "asd";
      sss.servico = "asd";

      PackageDAO().insert(sss);
      String x = "texto";
      //return Post.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

}