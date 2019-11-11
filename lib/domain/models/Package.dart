import 'dart:convert';

import 'package:meu_correios/domain/database/interfaces/i_mapper.dart';
import 'package:meu_correios/domain/models/Historic.dart';

class Package implements IMapper {
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

  static Package newInstace() {
    return new Package();
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'servico': servico,
    };
  }

  @override
  IMapper fromMappedJson(Map<String, dynamic> objJson) {
    this.codigo = objJson['codigo'];
    this.servico = objJson['servico'];
    return this;
  }
}