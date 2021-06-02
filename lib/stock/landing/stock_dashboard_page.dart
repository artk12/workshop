import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/all_items.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/warning.dart';
import 'package:workshop/stock/calculate_stock.dart';
import 'package:workshop/style/component/dashboard_card_background.dart';
import 'package:workshop/style/component/message_stock_Card.dart';
import 'package:workshop/style/component/stockpile/stock_log_dialog_Card.dart';
import 'package:workshop/style/component/stockpile/stock_stock_Card.dart';
import 'package:workshop/style/component/stockpile/warning_stock_Card.dart';
import 'package:workshop/style/theme/textstyle.dart';

class StockDashboardPage extends StatelessWidget {
  final List<Item> items;
  final List<ItemLog> itemLogs;
  final PageController pageController;
  final List<Fabric> fabrics;
  final List<Message> messages;

  StockDashboardPage(
      {this.items,
      this.pageController,
      this.itemLogs,
      this.fabrics,
      this.messages});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Warning> warnings = CalculateStock.generateWarningList(items);
    List<AllItem> allItems = CalculateStock.mergeFabricAndItem(items, fabrics);
    CalculateStock.sortAllItem(allItems);

    Widget title(String title, String icon, Function() onPress) {
      return GestureDetector(
        onTap: onPress,
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            Text(
              icon,
              style: MyTextStyle.iconStyle,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.primaryColor),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(title, style: theme.textTheme.headline2),
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('پیام', 'l', () {}),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: messages.length,
                          itemBuilder: (context, index) =>
                              MessageCard(message: messages[index])),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(
                      'انبار',
                      'h',
                      () {
                        pageController.animateToPage(1,
                            curve: Curves.easeIn,
                            duration: Duration(milliseconds: 200));
                      },
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    // Expanded(child: Row(children: [MessageCard(message:messages[0])],))
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allItems.length,
                        itemBuilder: (context, index) =>
                            allItems[index].category == 'fabric'
                                ? StockCard(
                                    name: ' پارچه ',
                                    quantifier: allItems[index].fabric.metric,
                                    quantify: 'متر',
                                  )
                                : StockCard(
                                    quantify: allItems[index].item.quantify,
                                    quantifier:
                                        allItems[index].item.quantifierOne,
                                    name: allItems[index].item.name,
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('هشدارها', 'f', () {}),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: warnings.length == 0
                          ? Center(
                              child: Text(
                              'هشداری وجود ندارد.',
                              style: theme.textTheme.bodyText1,
                            ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: warnings.length,
                              itemBuilder: (context, index) => WarningStockCard(
                                name: warnings[index].name,
                                quantify: warnings[index].quantify,
                                warning: warnings[index].warning,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('ورودی و خروجی ها', 'k', () {}),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: itemLogs.length,
                          itemBuilder: (context, index) => LogStockCard(
                                item: items.firstWhere((element) =>
                                    element.id == itemLogs[index].itemId),
                                itemLog: itemLogs[index],
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
