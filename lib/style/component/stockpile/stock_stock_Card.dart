import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class StockCard extends StatelessWidget {
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
                  'زیپ',
                  style: theme.textTheme.headline2!.copyWith(fontSize: 14),
                ),
                SizedBox(width: 5,),
                Text(
                  '10',
                  style: theme.textTheme.bodyText1!.copyWith(fontSize: 18),
                ),
                SizedBox(width: 5,),
                Text(
                  'بسته',
                  style: theme.textTheme.bodyText1!.copyWith(fontSize: 14),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
