import 'package:meu_correios/domain/models/Historic.dart';

class Package {
  final String codigo;
  final String servico;
  final List<Historic> historico;

  Package({
    this.codigo,
    this.servico,
    this.historico,
  });
}