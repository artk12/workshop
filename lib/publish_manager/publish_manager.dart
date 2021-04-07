import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/publish_manager/assignment.dart';
import 'package:workshop/publish_manager/dashboard.dart';
import 'package:workshop/publish_manager/monitoring.dart';
import 'package:workshop/publish_manager/monitoringTablet.dart';
import 'package:workshop/publish_manager/personnel.dart';
import 'package:workshop/publish_manager/personnel_log_mobile.dart';
import 'package:workshop/publish_manager/personnel_log_tablet.dart';
import 'package:workshop/publish_manager/tasks.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/device_detector.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';
import 'drawer_menu.dart';

// ignore: must_be_immutable
class PublishManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController normalPageController = new PageController(initialPage: 0);
    PageController steamPageController = new PageController(initialPage: 0);
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    SuperUser user = Provider.of<SuperUser>(context);
    List<Personnel> staff = Provider.of<List<Personnel>>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<Cut> cuts = Provider.of<List<Cut>>(context);
    List<Personnel> personnel = Provider.of<List<Personnel>>(context);
    List<TimerControllerProviderState> n = [];
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.bodyText2.copyWith(height: 2);
    TimerControllerProvider timerControllerProvider = TimerControllerProvider(timerControllerProviderState: n);

    RefreshProvider refreshProvider = Provider.of<RefreshProvider>(context);
    var size = MediaQuery.of(context).size;
    double itemHeight = 0;
    double itemWidth = 0;
    String device = DeviceDetector.deviceDetector();
    if (device == "tablet") {
      itemHeight = (size.height - kToolbarHeight - 20) / 1.5;
      itemWidth = size.width / 2;
    }

    return user == null ||
            staff == null ||
            tasks == null ||
            cuts == null ||
            personnel == null
        ? LoadingPage()
        : Scaffold(
            key: scaffoldKey,
            drawer: DrawerMenu(
              user: user,
              pageController: normalPageController,
              scaffoldKey: scaffoldKey,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  MyAppbar(
                    title: "داشبورد",
                    rightWidget: [
                      MyIconButton(
                        icon: MyIcons.DRAWER_ICON,
                        onPressed: () {
                          scaffoldKey.currentState.openDrawer();
                        },
                      )
                    ],
                    leftWidget: [
                      MyIconButton(
                        icon: MyIcons.PLUS,
                        onPressed: () {},
                      )
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: normalPageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        PersonnelPage(staff: staff, refreshProvider: refreshProvider),
                        AssignmentPage(
                          cuts: cuts,
                          tasks: tasks,
                          personnel: personnel,
                        ),
                        TasksPage(
                          tasks: tasks,
                          refreshProvider: refreshProvider,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
