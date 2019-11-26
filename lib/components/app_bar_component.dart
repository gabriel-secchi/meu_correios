import 'package:flutter/material.dart';

class AppBarComponent extends StatefulWidget implements PreferredSizeWidget {
  String textTitle;
  PreferredSizeWidget bottom;
  final void Function(String) filerCallback;

  AppBarComponent({
    Key key, 
    this.textTitle, 
    this.bottom,
    this.filerCallback,
  }) : super(key: key);

  @override
  _AppBarComponentState createState() => _AppBarComponentState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => setPreferredSize();

  Size setPreferredSize() {
    return Size(
      this.bottom.preferredSize.width,
      this.bottom.preferredSize.height * 2
    );
  }
}

class _AppBarComponentState extends State<AppBarComponent> with SingleTickerProviderStateMixin {
  Widget widgetTitle;
  Icon actionIconFilter;
  
  int animationStage = 1;
  AnimationController animationControllerTitle;
  Animation<double> animationTitle;

    
  @override
  void initState() {
    super.initState();
    widgetTitle = new Text(widget.textTitle);
    actionIconFilter = Icon(Icons.search);

    const animBegin = 1.0;
    const animEnd = 0.0;

    animationControllerTitle = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    animationTitle = Tween<double>(begin: animBegin, end: animEnd).animate(animationControllerTitle)
      ..addListener((){
        setState(() {});
      });

    animationControllerTitle.addStatusListener((status) {
      setState(() {
        if(status == AnimationStatus.completed) {
          if(animationStage == 1) {
            addFiterField();
          } 
          else if(animationStage == 2) {
            removeFilterField();
            this.widget.filerCallback("");
          }
        }
      });
    });
  }

  addFiterField(){
    setState(() {
      this.widgetTitle = new TextField(
        style: new TextStyle(
          color: Colors.white,
        ),
        decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search,color: Colors.white),
          hintText: "Search...",
          hintStyle: new TextStyle(color: Colors.white)
        ),
        autofocus: true,
        onChanged: (_text) => this.widget.filerCallback(_text),
      );
      animationStage = 2;
      animationControllerTitle.reverse();
    });
  }

  removeFilterField() {
    setState(() {
      this.widgetTitle = new Text(this.widget.textTitle);
      animationStage = 1;
      animationControllerTitle.reverse();
    });
  }


  @override
  void dispose() {
    super.dispose();
    animationControllerTitle.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return AppBar( 
      title: Opacity(
        opacity: animationTitle.value,
        child: this.widgetTitle,
      ),
      actions: <Widget>[
        IconButton(
          icon: this.actionIconFilter,
          onPressed: (){
            setState(() {
              if(this.actionIconFilter.icon == Icons.search)
                this.actionIconFilter = Icon(Icons.close);
              else 
                this.actionIconFilter = Icon(Icons.search);

              animationControllerTitle.forward();
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => setState (() async {
            //atualizar status das encomendas
          }),
        ),
      ],
      bottom: widget.bottom,
    );
  }
}