import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:workshop/module/stockpile/item.dart';

class ItemCardTablet extends StatelessWidget {
  final Item item;
  ItemCardTablet({this.item});
  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(
          height: height,
        );
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(5)),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color:item.category == "خرج کار"?Color(0xff79a4a6).withOpacity(0.1):Color(0xffab6954).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
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
                  space(24),
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
    );
  }
}
