
import 'package:flutter/material.dart';
import 'package:workshop/request/mylist.dart';

class RefreshProvider extends ChangeNotifier{
  Future items = MyList().getItems();//FutureProvider(create: (_) => MyList.getItems());
  Future fabrics = MyList().getFabrics();//FutureProvider(create: (_) => MyList.getFabrics());
  Future fabricLogs = MyList().getFabricLogs();//FutureProvider(create: (_) => MyList.getFabricLogs());
  Future itemLogs = MyList().getItemLogs();//FutureProvider(create: (_) => MyList.getItemLogs());
  Future messages = MyList().getStockPileMessages();//FutureProvider(create: (_) => MyList.getStockPileMessages());
  void refresh(){
    items = new MyList().getItems();//FutureProvider(create: (_) => MyList.getItems());
    fabrics = new MyList().getFabrics();//FutureProvider(create: (_) => MyList.getFabrics());
    fabricLogs = new MyList().getFabricLogs();//FutureProvider(create: (_) => MyList.getFabricLogs());
    itemLogs = new MyList().getItemLogs();//FutureProvider(create: (_) => MyList.getItemLogs());
    messages = new MyList().getStockPileMessages();//FutureProvider(create: (_) => MyList.getStockPileMessages());
    notifyListeners();
  }
}