import 'package:flutter/material.dart';
import 'package:workshop/style/component/dashboard_card_blur_background.dart';

class MessageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DashboardBlurBackgroundCard(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'موضوع',
              style: theme.textTheme.headline2.copyWith(fontSize: 14),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'این توضیحات است',
              style: theme.textTheme.bodyText1.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
