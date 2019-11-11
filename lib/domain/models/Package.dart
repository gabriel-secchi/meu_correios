import 'dart:convert';

import 'package:meu_correios/domain/models/Historic.dart';

class Package {
  String codigo;
  String descricao;
  String servico;
  List<Historic> historico;

  Package({
    this.codigo,
    this.descricao,
    this.servico,
    this.historico,
  });
}