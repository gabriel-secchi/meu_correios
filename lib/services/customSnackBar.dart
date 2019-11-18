import 'package:flutter/material.dart';

class CustomSnackBar {
  
  BuildContext context;
  CustomSnackBar({
    @required this.context
  });


  show(String texto, final Color bgColor, Duration time) {
    final scaffold = Scaffold.of(this.context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(texto, textAlign: TextAlign.center),
        duration: time,
        backgroundColor: bgColor,
      ),
    );
  }

  static showSuccess(final BuildContext context, final String texto) {
    CustomSnackBar csb = new CustomSnackBar(context: context);
    csb.show(texto, Colors.green, Duration(seconds: 2));
  }

  static showError(final BuildContext context, final String texto) {
    CustomSnackBar csb = new CustomSnackBar(context: context);
    csb.show(texto, Colors.red, Duration(seconds: 4));
  }

}