
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meu_correios/components/addPackage.dart';
import 'package:meu_correios/components/app_bar_component.dart';
import 'package:meu_correios/components/list_package/card_item_package.dart';
import 'package:meu_correios/components/list_package/package_list.dart';
import 'package:meu_correios/domain/dao/Package.DAO.dart';
import 'package:meu_correios/domain/models/Package.dart';

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

  List<Widget>_listItens = new List();

  onFilterChange(String asd) {
    setState(() {
      log(asd);
    });
  }

  @override
  void initState() {
    super.initState();
    _teste();
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
              //Icon(Icons.directions_car),
              //PackageList(packageType: PackageList.PACKAGE_ALL),
              ListView(
                children: _listItens,
              ),
              Icon(Icons.directions_transit),
              Scaffold(
                body: Center (child: Text("teste gabriel "),),
              )
            ],
          ),

          floatingActionButton: _buildButtonAddPackage()          
            
        ),
      ),
    );
  }

  _buildButtonAddPackage() {
    return new Builder(
      builder: (BuildContext ctxActionButtom) {
        return new FloatingActionButton(
          tooltip: "Adicionar encomenta",
          child: Icon(Icons.add),
          onPressed: () => setState(() {
            DialogAddPackage(ctxActionButtom).open( successcallback: _teste );
          }),
        );
      },
    );
  }

  _teste() {
    PackageDAO.getInstance().selectAllRows().then((listPackage) { 
      setState(() {
        _listItens = new List();
        for(Package package in listPackage){
          _listItens.add(
            Card(
                child: Center(
                  child: Text('cod rastreios: ${package.codigo}')
                )
              )
          );
        }
      });
    });
  }
}
