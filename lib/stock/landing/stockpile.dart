import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/landing/stock_landing_page.dart';

class StockPile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (_) => MyList.getItems()),
        FutureProvider(create: (_) => MyList.getFabrics()),
        FutureProvider(create: (_) => MyList.getFabricLogs()),
        FutureProvider(create: (_) => MyList.getItemLogs()),
      ],
      child: StockLandingPage(),
    );
  }
}
