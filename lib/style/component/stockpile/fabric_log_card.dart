import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/stock/landing/dialog_fabric.dart';

class FabricLogCard extends StatelessWidget {
  final FabricLogHolder fabricHolder;
  FabricLogCard({this.fabricHolder});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String input = "${fabricHolder.input.year}/${fabricHolder.input.month}/${fabricHolder.input.day}";
    String output = fabricHolder.output == null?'-':"${fabricHolder.output.year}/${fabricHolder.output.month}/${fabricHolder.output.day}";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 100,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color:Colors.black)
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                    child: Text(
                      "${fabricHolder.calite} #",
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'تاریح ورود :',
                            style:
                                theme.textTheme.bodyText1.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            input,
                            style:
                                theme.textTheme.bodyText1.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'تاریح خروج :',
                            style:
                                theme.textTheme.bodyText1.copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            output,
                            style:
                                theme.textTheme.bodyText1.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
