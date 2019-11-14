import 'package:flutter/material.dart';
import 'package:meu_correios/domain/models/Package.dart';

class CardItemPackage extends StatelessWidget {
  const CardItemPackage(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final Package item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
      
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              //color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('cod rastreio: ${item.codigo}', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}