import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/drawer_menu.dart';
import 'package:workshop/publish_manager/monitoring.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/device_detector.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

import 'dashboard.dart';

class PublishManagerLanding extends StatelessWidget {
  final SuperUser user;
  final List<Personnel> staff;
  final List<Task> tasks;
  final List<Cut> cuts;
  final List<Personnel> personnel;
  final TimerControllerProvider timerControllerProvider;
  final PersonnelLogProvider personnelLogProvider;

  PublishManagerLanding({
    this.tasks,
    this.personnel,
    this.user,
    this.cuts,
    this.staff,
    this.personnelLogProvider,
    this.timerControllerProvider,
  });
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.bodyText2.copyWith(height: 2);
    Size size = MediaQuery.of(context).size;
    double itemHeight = 0;
    double itemWidth = 0;
    String device = DeviceDetector.deviceDetector();
    if (device == "tablet") {
      itemHeight = (size.height - kToolbarHeight - 20) / 1.5;
      itemWidth = size.width / 2;
    }
    TimerStreamer timerStreamer = Provider.of(context);

    return PublishManageState(
      timerControllerProvider: timerControllerProvider,
      personnelLogProvider: personnelLogProvider,
      style: style,
      user: user,
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      cuts: cuts,
      personnel: personnel,
      tasks: tasks,
      device: device,
      timerStreamer: timerStreamer,
    );
  }
}

class PublishManageState extends StatelessWidget {
  final SuperUser user;
  final List<Task> tasks;
  final List<Cut> cuts;
  final List<Personnel> personnel;
  final TimerControllerProvider timerControllerProvider;
  final PersonnelLogProvider personnelLogProvider;
  final TextStyle style;
  final double itemWidth;
  final double itemHeight;
  final String device;
  final TimerStreamer timerStreamer;

  PublishManageState(
      {this.tasks,
      this.personnel,
      this.user,
      this.cuts,
      this.timerControllerProvider,
      this.personnelLogProvider,
      this.style,
      this.timerStreamer,
      this.itemHeight,
      this.itemWidth,
      this.device});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    // TimerStreamer timerStreamer = Provider.of<TimerStreamer>(context);
    // List<AssignmentLog> assignmentLogs =
    //     Provider.of<List<AssignmentLog>>(context) ?? [];
    // PublishManagerPageController pageController = Provider.of(context);

    // if (assignmentLogs.length >= personnelLogProvider.a.length) {
    //   personnelLogProvider.assignmentLogSetter = assignmentLogs;
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     MyShowSnackBar.showSnackBar(context, "وضعیت اینترنت خود را چک کنید..");
    //   });
    // }

    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerMenu(
        user: user,
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
                children: [
                  // true
                  //     ? ChangeNotifierProvider(
                  //         create: (_) => timerControllerProvider,
                  //         child: MonitoringMobilePage(
                  //           personnel: personnel,
                  //           itemWidth: itemWidth,
                  //           itemHeight: itemHeight,
                  //           tasks: timerStreamer,
                  //         ),
                  //       )
                  //     : Container(),
                  // pageController.page == DASHBOARD
                  //     ?
                  Dashboard(
                    style: style,
                    timerControllerProvider: timerControllerProvider,
                    itemWidth: itemWidth,
                    itemHeight: itemHeight,
                    device: device,
                    personnelLogProvider: personnelLogProvider,
                    timerStreamer: timerStreamer,
                    personnel: personnel,
                  )
                  //     : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MonitorCheck extends StatefulWidget {
  final List<AssignmentLog> assignmentLogs;
  final TimerStreamer timerStreamer;
  final TimerControllerProvider timerControllerProvider;
  final List<Personnel> personnel;
  final double itemWidth;
  final double itemHeight;
  final TimerStreamer tasks;

  MonitorCheck(
      {this.timerStreamer,
      this.assignmentLogs,
      this.timerControllerProvider,
      this.personnel,
      this.tasks,
      this.itemWidth,
      this.itemHeight});

  @override
  _MonitorCheckState createState() => _MonitorCheckState();
}

class _MonitorCheckState extends State<MonitorCheck> {
  Widget w;
  @override
  void initState() {
    w = ChangeNotifierProvider(
      create: (_) => widget.timerControllerProvider,
      child: MonitoringMobilePage(
        personnel: widget.personnel,
        itemWidth: widget.itemWidth,
        itemHeight: widget.itemHeight,
        timerStreamer: widget.tasks,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return w;
  }
}
