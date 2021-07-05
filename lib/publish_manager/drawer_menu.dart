import 'package:flutter/material.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/request/request.dart';

class DrawerMenu extends StatelessWidget {
  final SuperUser user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PublishManagerPageController dashboardPageController;
  final PageController pageController;
  final List<Message> messages;
  final PublishManagerPageController streamPageController;

  DrawerMenu(
      {this.user,
      this.scaffoldKey,
      this.dashboardPageController,
      this.pageController,
      this.messages,
      this.streamPageController});

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
            title: Text('داشبورد', style: theme.textTheme.headline2),
            onTap: () async {
              scaffoldKey.currentState.openEndDrawer();
              streamPageController.pageView = 0;
              if (pageController.page != 0) {
                await Future.delayed(Duration(milliseconds: 200));
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              }
              dashboardPageController.changePage(DASHBOARD);
            },
          ),
          ListTile(
            title: Text('پرسنل', style: theme.textTheme.headline2),
            onTap: () async {
              streamPageController.pageView = 1;
              scaffoldKey.currentState.openEndDrawer();
              await Future.delayed(Duration(milliseconds: 200));
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);
            },
          ),
          ListTile(
            title: Text('مانیتورینگ', style: theme.textTheme.headline2),
            onTap: () async {
              scaffoldKey.currentState.openEndDrawer();
              streamPageController.pageView = 0;
              await Future.delayed(Duration(milliseconds: 200));
              if (pageController.page != 0) {
                pageController.animateToPage(0,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              }
              dashboardPageController.changePage(MONITOR);
            },
          ),
          ListTile(
            title: Text('تقسیم وظایف', style: theme.textTheme.headline2),
            onTap: () async {
              scaffoldKey.currentState.openEndDrawer();
              streamPageController.pageView = 2;
              await Future.delayed(Duration(milliseconds: 200));
              if (pageController.page != 2) {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              }
            },
          ),
          ListTile(
            title: Text('فعالیتها', style: theme.textTheme.headline2),
            onTap: () async {
              streamPageController.pageView = 3;
              scaffoldKey.currentState.openEndDrawer();
              await Future.delayed(Duration(milliseconds: 200));
              pageController.animateToPage(3,
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);
              // showDialog(barrierColor: Colors.black12,context: context, builder: (context)=>DialogMessage(messages: messages,));
            },
          ),
          user.side == 'مدیر کل'?ListTile(
            title: Text('بازگشت به مدیریت', style: theme.textTheme.headline2),
            onTap: () {
              scaffoldKey.currentState.openEndDrawer();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
          ):ListTile(
            title: Text('خروج', style: theme.textTheme.headline2),
            onTap: () async{
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
