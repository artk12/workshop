import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class ActionStockCard extends StatelessWidget {
  final bool check ;
  ActionStockCard({this.check = false});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DashboardBlurBackgroundCard(
      color:check? Colors.green.withOpacity(0.2):Colors.redAccent.withOpacity(0.2),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              check?'10' + ' بسته زیپ '+'اضافه شد':'10' + ' بسته زیپ '+'کم شد',
              style: theme.textTheme.headline2!.copyWith(fontSize: 14),
            ),
            // SizedBox(
            //   height: 6,
            // ),
          ],
        ),
      ),
    );
  }
}
