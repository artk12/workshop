
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/publish_manager/monitoring.dart';
import 'package:workshop/publish_manager/personnel_log_tablet.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';

class MonitoringTablet extends StatelessWidget {
  final TimerControllerProvider timerControllerProvider;
  final List<Personnel> personnel;
  final double itemWidth;
  final double itemHeight;

  MonitoringTablet({this.timerControllerProvider,this.itemWidth,this.itemHeight,this.personnel});

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText2.copyWith(height: 2);
    return Row(
      children: [
        Expanded(
            flex: 1,
            child:ChangeNotifierProvider(
              create: (_)=>PersonnelLogProvider(),
              child: StreamProvider(
                create: (_)=>MyList().getAssignmentLogs(),
                child: PersonnelLogTablet(style: style,),
              ),
            ),
        ),
        Expanded(
         flex: 3,
         child:ChangeNotifierProvider(
           create: (_)=>timerControllerProvider,
           child: StreamProvider(
             create:(_)=> MyList.getRealAssignmentTask(personnel),
             child: MonitoringPage(
               personnel: personnel,
               itemWidth:itemWidth,
               itemHeight:itemHeight,
             ),
           ),
         ),
        ),
      ],
    );
  }
}
