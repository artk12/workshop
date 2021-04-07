
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/publish_manager/personnel_log_mobile.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';

import 'dashboard.dart';
import 'monitoring.dart';
import 'monitoringTablet.dart';

class StreamPages extends StatelessWidget {
  final PageController streamPageController;
  final String device;
  final TimerControllerProvider timerControllerProvider;
  final double itemHeight;
  final double itemWidth;
  final List<Personnel> personnel;
  final TextStyle style;

  StreamPages({this.streamPageController,this.timerControllerProvider,this.device,this.personnel,this.itemWidth,this.itemHeight,this.style});
  //TODO : THIS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: streamPageController,
        children: [
          Dashboard(),
          device == 'tablet'
              ? MonitoringTablet(
            itemHeight: itemHeight,
            itemWidth: itemWidth,
            personnel: personnel,
            timerControllerProvider:
            timerControllerProvider,
          )
              : ChangeNotifierProvider(
            create: (_) => timerControllerProvider,
            child: StreamProvider(
              create: (_) =>
                  MyList.getRealAssignmentTask(personnel),
              child: MonitoringPage(
                personnel: personnel,
                itemWidth: itemWidth,
                itemHeight: itemHeight,
              ),
            ),
          ),
          device == 'phone'?ChangeNotifierProvider(
            create: (_)=>PersonnelLogProvider(),
            child: StreamProvider(
              create: (_)=>MyList().getAssignmentLogs(),
              child: PersonnelLogMobile(style: style,),
            ),
          ):Container(),
        ],
      ),
    );
  }
}
