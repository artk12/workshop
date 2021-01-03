import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';

import 'dialog_item.dart';

class StockHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('asset/images/background_image.jpeg')),
              ),
            ),
            Container(
              color: Colors.black12,
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StockAppbar(
                    rightWidget: [
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                          ),
                          onPressed: () {}),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => DialogItem());
                        },
                      ),
                    ],
                    title: 'انبار',
                    leftWidget: [
                      IconButton(
                          icon: Icon(
                            Icons.notifications_none,
                          ),
                          onPressed: () {}),
                      IconButton(
                          icon: Icon(
                            Icons.refresh,
                          ),
                          onPressed: () {}),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
