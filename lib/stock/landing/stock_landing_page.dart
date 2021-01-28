import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/stock/export_from_stock/export_from_stock.dart';
import 'package:workshop/stock/landing/stock_dashboard_page.dart';
import 'package:workshop/stock/landing/stock_page.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import '../import_item_dialog.dart';

class StockLandingPage extends StatelessWidget {
  final RefreshProvider refreshProvider;
  final List<Item> items;
  final List<ItemLog> itemLogs;
  final List<Fabric> fabrics;
  final List<FabricLog> fabricLogs;
  final List<Message> messages;
  final User user;

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

    return StockBackground(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        drawer: BlurBackground(
          blur: 5,
          padding: EdgeInsets.zero,
          radius: 0,
          child: items == null ||
                  fabrics == null ||
                  itemLogs == null ||
                  fabricLogs == null ||
                  messages == null
              ? Container()
              : Container(
                  width: 200,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
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
                              Text(
                                user.side,
                                style: theme.textTheme.headline2.copyWith(
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
                                user.name,
                                style: theme.textTheme.headline1.copyWith(
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
                          'پیام ها',
                          style: theme.textTheme.headline1.copyWith(
                              fontSize: 18,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 7)
                              ]),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text(
                          'انبار',
                          style: theme.textTheme.headline1.copyWith(
                              fontSize: 18,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 7)
                              ]),
                        ),
                        onTap: () {
                          _scaffoldKey.currentState.openEndDrawer();
                          pageController.animateToPage(1,duration: Duration(milliseconds: 250),curve: Curves.easeIn);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'هشدارها',
                          style: theme.textTheme.headline1.copyWith(
                              fontSize: 18,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 7)
                              ]),
                        ),
                        onTap: () {
                          _scaffoldKey.currentState.openEndDrawer();
                          pageController.animateToPage(1,duration: Duration(milliseconds: 250),curve: Curves.easeIn);
                        },
                      ),
                      ListTile(
                        title: Text(
                          'ورودی و خروجی ها',
                          style: theme.textTheme.headline1.copyWith(
                              fontSize: 18,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 7)
                              ]),
                        ),
                        onTap: () {
                          _scaffoldKey.currentState.openEndDrawer();
                          pageController.animateToPage(1,duration: Duration(milliseconds: 250),curve: Curves.easeIn);
                        },
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
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.refresh,
                    ),
                    onPressed: () {
                      refreshProvider.refresh();
                    }),
              ],
              title: 'داشبورد',
              leftWidget: [
                IconButton(
                  icon: Icon(Icons.download_sharp),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImportItemDialog(
                        item: items,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.upload_sharp),
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
