import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/stock/landing/dialog_fabric.dart';

class FabricCardTablet extends StatelessWidget {
  final Fabric fabric;
  final List<FabricLog> fabricLogs;
  final List<Fabric> fabrics;
  FabricCardTablet({@required this.fabric,@required this.fabricLogs,@required this.fabrics});

  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(
          height: height,
        );
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        showDialog(context: context,builder: (context)=>FabricLogDialog(fabric: fabric,fabricLogs: fabricLogs,fabrics: fabrics,));
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff9c9972).withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
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
                          'پارچه',
                          style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    space(6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom:3),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border:Border(bottom: BorderSide(color: Colors.white.withOpacity(0.4),width: 1.5))
                          ),
                          child: Text(
                           fabric.calite,
                            style: theme.textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                    space(14),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fabric.pieces+' تکه ',
                            style: theme.textTheme.headline1,
                          ),
                          Text(
                            fabric.color,
                            style: theme.textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
                    space(7),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           fabric.manufacture,
                            style: theme.textTheme.headline1,
                          ),
                          Text(
                            fabric.metric+' متر ',
                            style: theme.textTheme.headline1,
                          ),
                        ],
                      ),
                    ),
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
