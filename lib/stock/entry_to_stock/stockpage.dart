

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/stock/landingpage.dart';

class StockPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return FutureProvider(
      create: (_)async => MyList().getAvailableItems(),
      child: StockLandingPage(),
    );
  }

}