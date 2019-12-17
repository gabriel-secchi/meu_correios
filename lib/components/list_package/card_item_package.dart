import 'package:flutter/material.dart';
import 'package:meu_correios/domain/models/Pacote.dart';

class CardItemPackage extends StatelessWidget {
  Pacote pacote;
  
  CardItemPackage({
    this.pacote
  });

  @override
  Widget build(BuildContext context) {
    if(pacote == null)
      return null;
      
    return Card(
        child: ListTile(
          title: Text(pacote.descricao),
          subtitle: Text(pacote.codigo),
        )
      );
  }
  
}