import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomLoading {

  BuildContext _context;

  CustomLoading(this._context);

  show( onLifeLoading ) async {
    final loading = Scaffold.of(this._context);
    loading.showSnackBar(
      SnackBar(
        backgroundColor: Colors.black45,
        content: Center(
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.grey
          )
        )
      )
    );

    final result = await onLifeLoading();

    loading.hideCurrentSnackBar();

    return result;
  }

}