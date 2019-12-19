import 'package:meu_correios/domain/models/Historico.dart';

class Pacote {
  String codigo;
  String descricao;
  String servico;
  List<Historico> historico;
  int status;
  bool arquivado = false;

  Pacote({
    this.codigo,
    this.descricao,
    this.servico,
    this.historico,
    this.status,
    this.arquivado
  });
}