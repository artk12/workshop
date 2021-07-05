import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/cutter/cutter.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/publish_manager.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/stock/landing/stockpile.dart';

import '../main.dart';
import '../my_shared_preferences.dart';

class GeneralDrawer extends StatelessWidget {
  final SuperUser user;
  final GlobalKey<ScaffoldState> scaffoldKey;

  GeneralDrawer({this.user, this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
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
                fit: BoxFit.contain,
                image: NetworkImage(MyRequest.baseUrl + user.profile),
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
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
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
            onTap: () async {
              scaffoldKey.currentState.openEndDrawer();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: RefreshProvider(),
                    child: StockPile(user: user),
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('برشکار', style: theme.textTheme.headline2),
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Cutter(user: user),
                ),
              );
            },
          ),
          ListTile(
            title: Text('مدیرخط', style: theme.textTheme.headline2),
            onTap: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChangeNotifierProvider.value(
                value: RefreshProvider(),
                child: MultiProvider(
                  providers: [
                    FutureProvider(create: (_) => MyList().getPersonnelList()),
                    FutureProvider(create: (_) => MyList().getTaskList()),
                    FutureProvider(create: (_) => MyList().getCutList()),
                    FutureProvider(create: (_) => MyList().getPersonnelMessages()),
                    FutureProvider(create: (_) => MyList().getScoreList()),
                    FutureProvider(create: (_) => MyList().getWarningList()),
                    FutureProvider(create: (_) => MyList().getAbsentList()),
                    FutureProvider(create: (_) => MyList().getTaskFolderList()),
                    ChangeNotifierProvider.value(value: PublishManagerPageController()),
                  ],
                  child: PublishManager(user: user),
                ),
              )));
            },
          ),
          ListTile(
            title: Text('خروج', style: theme.textTheme.headline2),
            onTap: () async {
              MySharedPreferences().clean();
              scaffoldKey.currentState.openEndDrawer();
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
    );
  }
}
