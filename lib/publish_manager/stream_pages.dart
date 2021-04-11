import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/personnel_log_mobile.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'dashboard.dart';
import 'monitoring.dart';

class StreamPages extends StatelessWidget {
  final PageController streamPageController;
  final String device;
  final double itemHeight;
  final TimerControllerProvider timerControllerProvider;
  final double itemWidth;
  final List<Personnel> personnel;
  final TextStyle style;
  final PersonnelLogProvider personnelLogProvider;
  final PublishManagerPageController pageController;
  final List<Message> messages;

  StreamPages(
      {this.streamPageController,
      this.timerControllerProvider,
      this.device,
      this.personnel,
      this.itemWidth,
      this.itemHeight,
      this.style,
      this.messages,
      this.personnelLogProvider,
      this.pageController});

  @override
  Widget build(BuildContext context) {
    TimerStreamer timerStreamer = Provider.of<TimerStreamer>(context);

    List<AssignmentLog> assignmentLogs =
        Provider.of<List<AssignmentLog>>(context) ?? [];
    if (assignmentLogs.length >= personnelLogProvider.a.length) {
      personnelLogProvider.assignmentLogSetter = assignmentLogs;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        MyShowSnackBar.showSnackBar(context, "وضعیت اینترنت خود را چک کنید..");
      });
    }

    return Stack(
      children: [
        pageController.page == DASHBOARD?Dashboard(
          timerStreamer: timerStreamer,
          personnelLogProvider: personnelLogProvider,
          device: device,
          itemHeight: itemWidth,
          itemWidth: itemHeight,
          timerControllerProvider: timerControllerProvider,
          style: style,
          personnel: personnel,
          assignmentLogs:assignmentLogs,
          messages: messages,
          pageController: pageController,
        ):Container(),
        pageController.page == MONITOR ? ChangeNotifierProvider(
          create: (_) => timerControllerProvider,
          child: WillPopScope(
            onWillPop: ()async{
              pageController.changePage(DASHBOARD);
              return false;
            },
            child: MonitoringMobilePage(
              dashboard: 'd',
              personnel: personnel,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              timerStreamer: timerStreamer,
            ),
          ),
        ):Container()
      ],
    );
  }
}
/*
 device == 'tablet'
              ? MonitoringTablet(
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            personnel: personnel,
            timerControllerProvider: timerControllerProvider,
            tasks: tasks,
            personnelLogProvider: personnelLogProvider,
          )
              : ChangeNotifierProvider(
            create: (_) => timerControllerProvider,
            child: MonitoringMobilePage(
              personnel: personnel,
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              tasks: tasks,
              streamPageController:streamPageController
            ),
          ),
          device == 'phone'?ChangeNotifierProvider(
            create: (_)=>personnelLogProvider,
            child: PersonnelLogMobile(style: style,personnelLogProvider: personnelLogProvider,streamPageController: streamPageController,),
          ):Container(),
 */
