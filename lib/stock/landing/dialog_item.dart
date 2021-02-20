import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/style/component/stockpile/dialog_background_blur.dart';
import 'package:workshop/style/component/stockpile/stock_log_dialog_Card.dart';

class ItemLogDialog extends StatelessWidget {
  final List<ItemLog> itemLogs;
  final Item item;
  ItemLogDialog({this.itemLogs, @required this.item});

  @override
  Widget build(BuildContext context) {
    List<ItemLog> currentItemLog = itemLogs.where((element) => element.itemId == item.id).toList();

    return BlurDialogBg(
      maxWidth: 400,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              currentItemLog.length,
              (index) => LogStockCard(
                item: item,
                itemLog: currentItemLog[index],
              ),
            ),
          )),
    );
  }
}
