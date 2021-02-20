import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/publish_manager/assignment.dart';
import 'package:workshop/publish_manager/dashboard.dart';
import 'package:workshop/publish_manager/monitoring.dart';
import 'package:workshop/publish_manager/personnel.dart';
import 'package:workshop/publish_manager/tasks.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'drawer_menu.dart';

class PublishManager extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    PageController pageController = new PageController(initialPage: 2);
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    User user = Provider.of<User>(context);

    return user == null ? LoadingPage():Scaffold(
      key: scaffoldKey,
      drawer: DrawerMenu(user:user,pageController: pageController,scaffoldKey: scaffoldKey,),
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              title: "داشبورد",
              rightWidget: [
                MyIconButton(
                  icon: MyIcons.DRAWER_ICON,
                  onPressed: (){
                    scaffoldKey.currentState.openDrawer();
                  },
                )
              ],
              leftWidget: [
                MyIconButton(
                  icon: MyIcons.PLUS,
                  onPressed: (){},
                )
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Dashboard(),
                  MonitoringPage(),
                  PersonnelPage(),
                  AssignmentPage(),
                  TasksPage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
