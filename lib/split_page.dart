import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/personnel/personnel_page.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/publish_manager.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/stock/landing/stockpile.dart';

import 'bloc/refresh_provider.dart';
import 'cutter/cutter.dart';
import 'general_manager/general_manager.dart';
import 'module/stockpile/user.dart';

class SplitPages extends StatelessWidget {
  final dynamic user;

  SplitPages({this.user});

  @override
  Widget build(BuildContext context) {
    if (user is User) {
      return MultiProvider(
        providers: [
          FutureProvider(create: (_) => MyRequest.getUserScore(user.id)),
          FutureProvider(
            create: (_) => MyList().getPersonnelMessages(),
          ),
        ],
        child: PersonnelPage(
          user: user,
        ),
      );
    } else if (user is SuperUser) {
      SuperUser s = user;
      if (s.side == "مدیریت انبار") {
        return ChangeNotifierProvider.value(
          value: RefreshProvider(),
          child: StockPile(user: s),
        );
      } else if (s.side == "برشکار") {
        return Cutter(user: user);
      } else if (s.side == "مدیر تولید") {
        return ChangeNotifierProvider.value(
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
              ChangeNotifierProvider.value(value: PublishManagerPageController()),
            ],
            child: PublishManager(user: s),
          ),
        );
      } else if (s.side == "مدیر کل") {
        return ChangeNotifierProvider.value(
          value: RefreshProvider(),
          child: MultiProvider(
            providers: [
              FutureProvider(create: (_) => MyList.getAllProjects(),),
              FutureProvider(create: (_) => MyList.getAllStyleCode(),),
            ],
            child: GeneralManager(),
          ),
        );
      }
    }
    return Container(
      color: Colors.lightGreen,
    );
  }
}
