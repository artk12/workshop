import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
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

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:Colors.black.withOpacity(0.3),
        border: Border.all(color: itemLog.log == '1'? Color(0xff5fff42).withOpacity(0.4):Color(0xffff4242).withOpacity(0.6),width: 1.5),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            itemLog.log == '1'? import():export(),
            style: theme.textTheme.bodyText2.copyWith(height: 2),
          ),
        ],
      ),
    );
  }
}
