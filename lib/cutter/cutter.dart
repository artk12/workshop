import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/cutter/cutter_landing.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/mylist.dart';

class Cutter extends StatelessWidget {
  final SuperUser user;

  Cutter({this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RefreshProvider(),
      child: MultiProvider(
        providers: [
          FutureProvider(create: (_) => MyList().getCutterMessages()),
          FutureProvider(create: (_) => MyList().getCutList()),
          FutureProvider(create: (_) => MyList.getAllStyleCode(),
          )
        ],
        child: CutterLanding(user: user),
      ),
    );
  }
}
