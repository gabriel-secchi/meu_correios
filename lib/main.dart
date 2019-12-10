import 'package:flutter/material.dart';
import 'package:meu_correios/components/addPackage.dart';
import 'package:meu_correios/components/app_bar_component.dart';
import 'package:meu_correios/components/list_package/package_list.dart';

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

  PackageList _packageList;
  String _textFilter;

  @override
  void initState() {
    super.initState();
     _packageList = new PackageList(packageType: PackageList.PACKAGE_ALL);
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
            filerCallback: (_param) => _onFilterChange(_param),
          ),
          
          body: TabBarView(
            children: [
              _packageList,


              Icon(Icons.directions_car),
              

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
          onPressed: () =>
            setState(() {
              DialogAddPackage(ctxActionButtom).open( successcallback: _successAddPackage );
          }),
        );
      },
    );
  }

  _onFilterChange(String textFilter) {
    setState(() {
      _textFilter = textFilter;
      _packageList.filtrar(textFilter);
    });
  }

  _successAddPackage() => _onFilterChange(_textFilter);

}
