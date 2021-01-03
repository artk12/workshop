import 'package:flutter/material.dart';
import 'package:workshop/stock/entry_to_stock/add_available_item.dart';
import 'package:workshop/stock/homepage.dart';
import 'package:workshop/style/theme/theme.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context , child)=>Directionality(textDirection: TextDirection.rtl, child: child),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // '/': (context) => StockHomePage(),
      },
      theme: light,
      home: AvailableItem(),
    );
  }
}
