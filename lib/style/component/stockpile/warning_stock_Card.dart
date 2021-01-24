import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class WarningStockCard extends StatelessWidget {
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
              'زیپ کمتر از 10',
              style: theme.textTheme.headline2.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
