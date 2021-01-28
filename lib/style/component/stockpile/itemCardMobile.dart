import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/stock/landing/dialog_item.dart';
import 'package:workshop/style/component/blur_background.dart';

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
      child: BlurBackground(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: 122,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: item.category == "خرج کار"
                        ? AssetImage('asset/images/img_2.jpg')
                        : AssetImage('asset/images/img_1.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 122,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.65),
                      spreadRadius: 20,
                      blurRadius: 10),
                ],
              ),
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
