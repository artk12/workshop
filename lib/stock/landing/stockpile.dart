import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/stock/landing/stock_landing_page.dart';
import 'package:workshop/stock/loading_page.dart';

class StockPile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of<RefreshProvider>(context);
    User user = Provider.of(context);


    return user == null? LoadingPage():FutureBuilder(
      future: refreshProvider.items,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Item> items = snapshot.data;
          return FutureBuilder(
            future: refreshProvider.fabrics,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Fabric> fabrics = snapshot.data;
                return FutureBuilder(
                  future: refreshProvider.fabricLogs,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<FabricLog> fabricLogs = snapshot.data;
                      return FutureBuilder(
                        future: refreshProvider.itemLogs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ItemLog> itemLogs = snapshot.data;
                            return FutureBuilder(
                              future: refreshProvider.messages,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Message> messages = snapshot.data;
                                  return StockLandingPage(
                                    refreshProvider: refreshProvider,
                                    fabricLogs: fabricLogs,
                                    fabrics: fabrics,
                                    itemLogs: itemLogs,
                                    items: items,
                                    messages: messages,
                                    user: user,
                                  );
                                } else {
                                  return LoadingPage();
                                }
                              },
                            );
                          } else {
                            return LoadingPage();
                          }
                        },
                      );
                    } else {
                      return LoadingPage();
                    }
                  },
                );
              } else {
                return LoadingPage();
              }
            },
          );
        } else {
          return LoadingPage();
        }
      },
    );
    // return MultiProvider(
    //   providers: [
    //     FutureProvider.value(value: MyList.getItems()),
    //     FutureProvider.value(value:  MyList.getFabrics()),
    //     FutureProvider.value(value:  MyList.getFabricLogs()),
    //     FutureProvider.value(value:  MyList.getItemLogs()),
    //     FutureProvider.value(value:  MyList.getStockPileMessages()),
    //   ],
    //   child: StockLandingPage(refreshProvider:refreshProvider),
    // );
  }
}
