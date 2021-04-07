import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/publish_manager/publish_manager.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/import_to_stock/update_item.dart';
import 'package:workshop/stock/import_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/import_to_stock/add_new_item.dart';
import 'package:workshop/stock/landing/stockpile.dart';
import 'package:workshop/style/theme/theme.dart';

import 'module/stockpile/user.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '.': (context) => StockPile(),
        '/addFabric': (context) => AddFabricItem(),
        '/addNewItem': (context) => AddNewItem(),
        '/addAvailableItem': (context) => UpdateItem(),
        // '/': (context) => StockHomePage(),
      },
      theme: light,
      // home: MultiProvider(
      //   providers: [
      //     FutureProvider(create:(_)=>MyRequest.getNormalUserDetail('3450101010','123456'),),
      //     FutureProvider(create:(_)=>MyList().getPersonnelMessages(),),
      //   ],
      //   child: PersonnelPage(),
      // ),
      home: ChangeNotifierProvider.value(
        value: RefreshProvider(),
        child: MultiProvider(
          providers: [
            FutureProvider(create: (_)async{return SuperUser(id: '1',user: '09176468332',pass: '1243',side: 'مدیرتولید',profile: 'sss',name: 'مسلم بایرامی');},),
            FutureProvider(create: (_)=>MyList().getPersonnelList()),
            FutureProvider(create: (_)=>MyList().getTaskList()),
            FutureProvider(create: (_)=>MyList().getCutList(),),
          ],
          child: PublishManager(),
        ),
      ),
      // home: Cutter(),
      // home: GeneralManager(),
      // home: FutureProvider(
      //   create: (_)=>MyRequest.getUserDetail('09176468835', '12345678'),
      //   child: ChangeNotifierProvider.value(
      //     value: RefreshProvider(),
      //     child: StockPile(),
      //   ),
      // ),
    );
  }
}
