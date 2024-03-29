import 'package:flutter/material.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/request.dart';

import '../my_shared_preferences.dart';

class CutterDrawerMenu extends StatelessWidget {
  final SuperUser user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController pageController;

  CutterDrawerMenu({this.scaffoldKey, this.user, this.pageController});

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
                fit: BoxFit.cover,
                image: NetworkImage(MyRequest.baseUrl + '/' + user.profile),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      user.side,
                      style: theme.textTheme.headline2.copyWith(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 15,
                        shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      user.name,
                      style: theme.textTheme.headline1.copyWith(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 14,
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
            title: Text('برش های موجود', style: theme.textTheme.headline2),
            onTap: () {
              scaffoldKey.currentState.openEndDrawer();
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);
            },
          ),
          user.side == 'مدیر کل'
              ? ListTile(
                  title: Text('بازگشت به مدیریت',
                      style: theme.textTheme.headline2),
                  onTap: () {
                    scaffoldKey.currentState.openEndDrawer();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  },
                )
              : ListTile(
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
