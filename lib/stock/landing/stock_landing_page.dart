import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/stock/landing/stock_dashboard_page.dart';
import 'package:workshop/stock/landing/stockpile_list_page.dart';
import 'package:workshop/stock/landing/stockpile_messages_page.dart';
import 'package:workshop/stock/landing/stockpile_warning_page.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import '../dialog_item.dart';

class StockLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>(); // ADD THIS LINE
    List<ItemNameAvailable> availableItems =
        Provider.of<List<ItemNameAvailable>>(context) ?? [];
    PageController pageController = new PageController();
    ThemeData theme = Theme.of(context);

    return StockBackground(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: BlurBackground(
          blur: 5,
          padding: EdgeInsets.zero,
          radius: 0,
          child: Container(
            width: 200,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('asset/images/profile.jpg'),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مدیریت انبار',
                          style: theme.textTheme.headline2!.copyWith(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 8)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "محمد اسحاقی",
                          style: theme.textTheme.headline1!.copyWith(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 8)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'انبار',
                    style: theme.textTheme.headline1!.copyWith(
                        fontSize: 18,
                        shadows: [Shadow(color: Colors.black, blurRadius: 7)]),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'هشدارها',
                    style: theme.textTheme.headline1!.copyWith(
                        fontSize: 18,
                        shadows: [Shadow(color: Colors.black, blurRadius: 7)]),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text(
                    'ورودی و خروجی ها',
                    style: theme.textTheme.headline1!.copyWith(
                        fontSize: 18,
                        shadows: [Shadow(color: Colors.black, blurRadius: 7)]),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            StockAppbar(
              rightWidget: [
                IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.notifications_none,
                    ),
                    onPressed: () {}),
              ],
              title: 'داشبورد',
              leftWidget: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogItem(
                        availableItems: availableItems,
                      ),
                    );
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.refresh,
                    ),
                    onPressed: () {}),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: [
                  StockDashboardPage(
                    availableItems: availableItems,
                  ),
                  StockMessageList(),
                  StockPileList(),
                  StockWarningList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
