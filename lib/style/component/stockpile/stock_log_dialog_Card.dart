import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';

import '../dashboard_card_blur_background.dart';

class LogStockCard extends StatelessWidget {
  final ItemLog itemLog;
  final Item item;
  LogStockCard({this.itemLog,@required this.item});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String import(){
      return itemLog.amount +' ' + item.quantify+ ' '+item.name+' '+ ' در تاریخ '+'${itemLog.year}/${itemLog.month}/${itemLog.day}'+' اضافه شد. ';
    }

    String export(){
      return itemLog.amount +' ' + item.quantify+' '+' در تاریخ '+'${itemLog.year}/${itemLog.month}/${itemLog.day}' + ' توسط '+itemLog.person+' خارج شد.';
    }

    return DashboardBlurBackgroundCard(
      color:itemLog.log == '1'? Colors.green.withOpacity(0.2):Colors.redAccent.withOpacity(0.2),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              itemLog.log == '1'? import():export(),
              style: theme.textTheme.headline2.copyWith(fontSize: 14,height: 2),
            ),
          ],
        ),
      ),
    );
  }
}
