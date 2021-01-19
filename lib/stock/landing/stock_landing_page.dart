import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/stock/export_from_stock/export_from_stock.dart';
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
        new GlobalKey<ScaffoldState>();
    List<Item> items = Provider.of<List<Item>>(context) ?? [];
    List<Fabric> fabrics = Provider.of<List<Fabric>>(context) ?? [];
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
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('asset/images/profile.jpg'),
                    ),
                  ),
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
                    'پیام ها',
                    style: theme.textTheme.headline1!.copyWith(
                        fontSize: 18,
                        shadows: [Shadow(color: Colors.black, blurRadius: 7)]),
                  ),
                  onTap: () {},
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
                      Icons.refresh,
                    ),
                    onPressed: () {}),
              ],
              title: 'داشبورد',
              leftWidget: [
                IconButton(
                  icon: Icon(Icons.download_outlined),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => DialogItem(
                        item: items,
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.upload_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExportFromStock(
                          items:items,
                          fabrics:fabrics,
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
                children: [
                  StockDashboardPage(
                    items: items,
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
