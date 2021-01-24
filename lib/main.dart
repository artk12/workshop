import 'package:flutter/material.dart';
import 'package:workshop/stock/import_to_stock/update_item.dart';
import 'package:workshop/stock/import_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/import_to_stock/add_new_item.dart';
import 'package:workshop/stock/landing/stockpile.dart';
import 'package:workshop/style/theme/theme.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context , child)=>Directionality(textDirection: TextDirection.rtl, child: child),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/addFabric':(context)=>AddFabricItem(),
        '/addNewItem':(context)=>AddNewItem(),
        '/addAvailableItem':(context)=>UpdateItem(),
        // '/': (context) => StockHomePage(),
      },
      theme: light,
      home: StockPile()
    );
  }
}
