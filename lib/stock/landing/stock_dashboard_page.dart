import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/dashboard_card_background_blur.dart';
import 'package:workshop/style/component/dashboard_card_blur_background.dart';
import 'package:workshop/style/component/stockpile/message_stock_Card.dart';
import 'package:workshop/style/component/stockpile/stock_action_stock_Card.dart';
import 'package:workshop/style/component/stockpile/stock_stock_Card.dart';
import 'package:workshop/style/component/stockpile/warning_stock_Card.dart';

import '../dialog_item.dart';

class StockDashboardPage extends StatelessWidget {
  final List<ItemNameAvailable>? availableItems;
  StockDashboardPage({this.availableItems});
  @override
  Widget build(BuildContext context) {
    // List<ItemNameAvailable> availableItems =
    //     Provider.of<List<ItemNameAvailable>>(context) ?? [];
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DashboardCardBackgroundBlur(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: theme.primaryColor),
                        ),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'پیام ها  ',
                        style: theme.textTheme.headline2!.copyWith(shadows: [
                          Shadow(color: Colors.black, blurRadius: 8)
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) => MessageCard()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackgroundBlur(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: theme.primaryColor),
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 8),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'انبار : ',
                        style: theme.textTheme.headline2!.copyWith(shadows: [
                          Shadow(color: Colors.black, blurRadius: 8)
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) => StockCard()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackgroundBlur(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                          BorderSide(width: 1, color: theme.primaryColor),
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 8),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'هشدارها : ',
                        style: theme.textTheme.headline2!.copyWith(shadows: [
                          Shadow(color: Colors.black, blurRadius: 8)
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) => WarningStockCard()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackgroundBlur(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                          BorderSide(width: 1, color: theme.primaryColor),
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 8),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Text(
                        'ورودی و خروجی ها : ',
                        style: theme.textTheme.headline2!.copyWith(shadows: [
                          Shadow(color: Colors.black, blurRadius: 8)
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) => ActionStockCard(
                                check: index % 2 == 0 ? true : false,
                              )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),

    );
  }
}
