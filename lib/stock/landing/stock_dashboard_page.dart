import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/style/component/dashboard_card_background_blur.dart';
import 'package:workshop/style/component/stockpile/message_stock_Card.dart';
import 'package:workshop/style/component/stockpile/stock_action_stock_Card.dart';
import 'package:workshop/style/component/stockpile/stock_stock_Card.dart';
import 'package:workshop/style/component/stockpile/warning_stock_Card.dart';

class StockDashboardPage extends StatelessWidget {
  final List<Item> items;
  final PageController pageController;
  StockDashboardPage({this.items,this.pageController});
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);
    Widget title(String title,IconData icon , Function() onPress){
      return GestureDetector(
        onTap: onPress,
        child: Row(
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
                title,
                style: theme.textTheme.headline2.copyWith(shadows: [
                  Shadow(color: Colors.black, blurRadius: 8)
                ]),
              ),
            ),
            Icon(icon,size: 22,),
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
            DashboardCardBackgroundBlur(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('پیام', Icons.message, () {}),
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
                    title('انبار', Icons.home_outlined, () {pageController.animateToPage(1,curve: Curves.easeIn,duration: Duration(milliseconds: 200));}),
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
                    title('هشدارها', Icons.warning, () {}),
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
                    title('ورودی و خروجی ها', Icons.transform, () {}),
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
