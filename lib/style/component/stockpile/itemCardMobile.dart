import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/stock/landing/dialog_item.dart';

class ItemCardMobile extends StatelessWidget {
  final Item item;
  final List<ItemLog> itemLogs;
  ItemCardMobile({this.item,@required this.itemLogs});
  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(
          height: height,
        );
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        showDialog(context: context,builder: (context)=>ItemLogDialog(itemLogs: itemLogs,item: item,));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            // Container(
            //   width: double.maxFinite,
            //   height: 122,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: item.category == "خرج کار"
            //             ? AssetImage('asset/images/img_2.jpg')
            //             : AssetImage('asset/images/img_1.jpg'),
            //         fit: BoxFit.cover),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                color:item.category == "خرج کار"?Color(0xff79a4a6).withOpacity(0.1):Color(0xffab6954).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)
              ),
              width: double.maxFinite,
              height: 122,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.maxFinite,
                height: 122,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    space(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.category,
                          style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    space(8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.white.withOpacity(0.4),
                                      width: 1.5))),
                          child: Text(
                            item.name,
                            style: theme.textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                    space(15),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${item.quantifierOne} ',
                            style: theme.textTheme.headline1,
                          ),
                          Text(
                            item.quantify,
                            style: theme.textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                    space(7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
