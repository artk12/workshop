import 'package:flutter/material.dart';
import 'package:workshop/stock/entry_to_stock/add_available_item.dart';
import 'package:workshop/stock/entry_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/entry_to_stock/add_new_item.dart';
import 'package:workshop/stock/entry_to_stock/stockpage.dart';
import 'package:workshop/style/theme/theme.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context , child)=>Directionality(textDirection: TextDirection.rtl, child: child!),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/addFabric':(context)=>AddFabricItem(),
        '/addNewItem':(context)=>AddNewItem(),
        '/addAvailableItem':(context)=>AddAvailableItem(),
        // '/': (context) => StockHomePage(),
      },
      theme: light,
      home: StockPage(),
    );
  }
}
