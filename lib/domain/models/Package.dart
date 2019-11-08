import 'package:meu_correios/domain/database/interfaces/i_mapper.dart';
import 'package:meu_correios/domain/models/Historic.dart';

class Package implements IMapper {
  String codigo;
  String servico;
  List<Historic> historico;

  Package({
    this.codigo,
    this.servico,
    this.historico,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'codigo': codigo,
      'servico': servico,
    };
  }
}