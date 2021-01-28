import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class StockCard extends StatelessWidget {
  final String quantify;
  final String name;
  final String quantifier;

  StockCard({this.quantify,this.name,this.quantifier});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DashboardBlurBackgroundCard(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                 name,
                  style: theme.textTheme.headline2.copyWith(fontSize: 14),
                ),
                SizedBox(width: 5,),
                Text(
                  quantifier,
                  style: theme.textTheme.bodyText1.copyWith(fontSize: 18),
                ),
                SizedBox(width: 5,),
                Text(
                  quantify,
                  style: theme.textTheme.bodyText1.copyWith(fontSize: 14),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
