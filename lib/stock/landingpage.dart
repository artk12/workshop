
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';

import 'dialog_item.dart';

class StockLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ItemNameAvailable> availableItems = Provider.of<List<ItemNameAvailable>>(context)??[];
    // ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: StockBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StockAppbar(
                  rightWidget: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                        ),
                        onPressed: () {}),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => DialogItem(availableItems: availableItems,));
                      },
                    ),
                  ],
                  title: 'انبار',
                  leftWidget: [
                    IconButton(
                        icon: Icon(
                          Icons.notifications_none,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.refresh,
                        ),
                        onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
