import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/stock/landing/dialog_fabric.dart';
import 'package:workshop/style/component/blur_background.dart';

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
      child: BlurBackground(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/img_3.jpg'),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.7),spreadRadius: 20,blurRadius: 5),
                ],
                // color: Colors.black.withOpacity(0.5),
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
                          style: theme.textTheme.bodyText1.copyWith(fontSize: 16,shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
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
                            style: theme.textTheme.headline1.copyWith(shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
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
                            fabric.pieces+' تیکه ',
                            style: theme.textTheme.headline1.copyWith(fontSize: 17,shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
                          ),
                          Text(
                            'سفید',
                            style: theme.textTheme.headline1.copyWith(fontSize: 17,shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
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
                            style: theme.textTheme.headline1.copyWith(fontSize: 17,shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
                          ),
                          Text(
                            fabric.metric+' متر ',
                            style: theme.textTheme.headline1.copyWith(fontSize: 17,shadows: [Shadow(color: Colors.black,blurRadius: 8)]),
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
