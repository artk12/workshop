import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class WarningStockCard extends StatelessWidget {
  final String name;
  final String warning;
  final String quantify;
  WarningStockCard({this.name,this.quantify,this.warning});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DashboardBlurBackgroundCard(
      color: Colors.redAccent.withOpacity(0.3),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              name + ' به کمتر از '+warning+' '+quantify+' رسید. ',
              style: theme.textTheme.headline2.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
