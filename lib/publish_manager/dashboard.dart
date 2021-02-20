
import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/style/component/dashboard_card_background.dart';
import 'package:workshop/style/component/message_stock_Card.dart';
import 'package:workshop/style/component/publish_manager/monitor_card.dart';
import 'package:workshop/style/component/publish_manager/notification_card.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(height: height,);
    ThemeData theme = Theme.of(context);

    Widget title(String title,Function() onPress) {
      return GestureDetector(
        onTap: onPress,
        child: Row(
          children: [
            space(15),
            // Text(
            //   icon,
            //   style: MyTextStyle.iconStyle,
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.primaryColor),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(
                  title,
                  style: theme.textTheme.headline2
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          space(10),
          DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('اعلانها',() {}),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) => NotificationCard()),
                    ),
                  ],
                ),
              ),
          ),
          space(20),
          DashboardCardBackground(
            child: Container(
              height: 280,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title('مانیتورینگ',() {}),
                  SizedBox(
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => MonitorCard()),
                  ),
                ],
              ),
            ),
          ),
          space(20),
          DashboardCardBackground(
            child: Container(
              height: 200,
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title('پیامها',() {}),
                  SizedBox(
                    height: 2,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) => MessageCard(message: Message(id: '1',message: 'سلام من خزبعلیجات هستم',title: 'خزبعلیجات'),)),
                  ),
                ],
              ),
            ),
          ),
          space(20),
        ],
      ),
    );
  }
}
