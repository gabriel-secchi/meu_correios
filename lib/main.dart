
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_correios/components/addPackage.dart';
import 'package:meu_correios/components/app_bar_component.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
    
  onFilterChange(String asd) {
    setState(() {
      log(asd);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBarComponent(
            textTitle: widget.title,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.all_inclusive)),
                Tab(icon: Icon(Icons.local_shipping)),
                Tab(icon: Icon(Icons.archive)),
              ],
            ),
            filerCallback: (_param) => onFilterChange(_param),
          ),
          
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Scaffold(
                body: Center (child: Text("teste gabriel "),),
              )
            ],
          ),

          floatingActionButton: new Builder(
            builder: (BuildContext ctxActionButtom) {
              return new FloatingActionButton(
                tooltip: "Adicionar encomenta",
                child: Icon(Icons.add),
                onPressed: ()   => setState(() {
                  AddPackage.dialog(ctxActionButtom);
                  //CustomSnackBar.showSuccess(ctxActionButtom, "teste");
                }),
              );
            },
          ),
          
            
        ),
      ),
    );
  }
}
