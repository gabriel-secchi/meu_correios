import 'package:flutter/material.dart';
import 'package:meu_correios/domain/models/Package.dart';

class CardItemPackage extends StatelessWidget {
  Package package;
  
  CardItemPackage({
    this.package
  });

  @override
  Widget build(BuildContext context) {
    if(package == null)
      return null;
      
    return Card(
        child: Center(
          child: Text('rastreios gs: ${package.codigo}')
        )
      );
  }
  
}