import 'package:flutter/material.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/style/component/cutter/cut_card.dart';
import 'package:workshop/style/component/dashboard_card_background.dart';
import 'package:workshop/style/component/message_stock_Card.dart';
import 'package:workshop/style/theme/textstyle.dart';

class CutterDashboard extends StatelessWidget {
  final List<Message> messages;
  final PageController pageController;
  final List<Cut> cutList;

  CutterDashboard({this.messages, this.pageController, this.cutList});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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

    return SingleChildScrollView(
      child: Column(children: [
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
        SizedBox(height: 20),
        DashboardCardBackground(
          child: Container(
            height: 200,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('برش های موجود', 'm', () {
                  pageController.animateToPage(1,
                      curve: Curves.easeIn,
                      duration: Duration(milliseconds: 200));
                }),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: cutList.length < 10 ? cutList.length : 10,
                      itemBuilder: (context, index) => CutCard(
                            cut: cutList[index],
                          )),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
