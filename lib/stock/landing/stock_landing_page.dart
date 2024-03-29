import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/stock/export_from_stock/export_from_stock.dart';
import 'package:workshop/stock/landing/stock_dashboard_page.dart';
import 'package:workshop/stock/landing/stock_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';

import '../import_to_stock/dialog_import_item.dart';

class StockLandingPage extends StatelessWidget {
  final RefreshProvider refreshProvider;
  final List<Item> items;
  final List<ItemLog> itemLogs;
  final List<Fabric> fabrics;
  final List<FabricLog> fabricLogs;
  final List<Message> messages;
  final SuperUser user;

  StockLandingPage(
      {this.refreshProvider,
      this.fabrics,
      this.fabricLogs,
      this.items,
      this.itemLogs,
      this.messages,
      this.user});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    // List<Item> items = Provider.of<List<Item>>(context);
    // List<Fabric> fabrics = Provider.of<List<Fabric>>(context);
    // List<ItemLog> itemLogs = Provider.of<List<ItemLog>>(context);
    // List<FabricLog> fabricLogs = Provider.of<List<FabricLog>>(context);
    // List<Message> messages = Provider.of<List<Message>>(context);
    // RefreshProvider refreshProvider = Provider.of<RefreshProvider>(context);
    PageController pageController = new PageController(initialPage: 0);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: items == null ||
              fabrics == null ||
              itemLogs == null ||
              fabricLogs == null ||
              messages == null
          ? Container()
          : Container(
              color: Color(0xFFECECEC),
              width: 200,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            MyRequest.baseUrl + '/' + user.profile),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              user.side,
                              style: theme.textTheme.headline2.copyWith(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 15,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 3)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(
                              user.name,
                              style: theme.textTheme.headline1.copyWith(
                                color: Colors.black.withOpacity(0.9),
                                fontSize: 15,
                              ),
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
                    title: Text('انبار', style: theme.textTheme.headline2),
                    onTap: () {
                      _scaffoldKey.currentState.openEndDrawer();
                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeIn);
                    },
                  ),
                  user.side == 'مدیر کل'?ListTile(
                    title: Text('بازگشت به مدیریت', style: theme.textTheme.headline2),
                    onTap: () {
                      _scaffoldKey.currentState.openEndDrawer();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                  ):
                  ListTile(
                    title: Text('خروج', style: theme.textTheme.headline2),
                    onTap: () async {
                      MySharedPreferences().clean();
                      _scaffoldKey.currentState.openEndDrawer();
                      await Future.delayed(Duration(milliseconds: 250));
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              rightWidget: [
                MyIconButton(
                  icon: MyIcons.DRAWER_ICON,
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                MyIconButton(
                    icon: MyIcons.REFRESH,
                    onPressed: () {
                      refreshProvider.refresh();
                    }),
              ],
              title: 'داشبورد',
              leftWidget: [
                MyIconButton(
                  icon: MyIcons.ARROW_DOWN,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImportItemDialog(
                        item: items,
                      ),
                    );
                  },
                ),
                MyIconButton(
                  icon: MyIcons.ARROW_UP,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExportFromStock(
                          items: items,
                          fabrics: fabrics,
                        ),
                        settings: RouteSettings(name: '/ExportFromStock'),
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  StockDashboardPage(
                      itemLogs: itemLogs.take(10).toList(),
                      items: items.take(10).toList(),
                      pageController: pageController,
                      fabrics: fabrics.take(10).toList(),
                      messages: messages),
                  StockPage(
                    pageController: pageController,
                    fabricLogs: fabricLogs,
                    fabrics: fabrics,
                    itemLogs: itemLogs,
                    items: items,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
