import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/style/component/publish_manager/monitor_card.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';

class DashboardMonitoringMobilePage extends StatefulWidget {
  final List<Personnel> personnel;
  final double itemHeight;
  final double itemWidth;
  final TimerStreamer tasks;
  // final PageController streamPageController;
  // final String dashboard;

  DashboardMonitoringMobilePage(
      {this.personnel,
      this.itemHeight,
      this.itemWidth,
      this.tasks,});

  @override
  _DashboardMonitoringMobilePageState createState() => _DashboardMonitoringMobilePageState();
}

class _DashboardMonitoringMobilePageState extends State<DashboardMonitoringMobilePage> {
  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    // TimerStreamer tasks = Provider.of<TimerStreamer>(context);
    ThemeData theme = Theme.of(context);

    int checkWarning() {
      if (p.warning) {
        return 26;
      } else {
        return 101;
      }
    }

    bool getPercentageItems(String id) {
      try {
        if (p.timerControllerProviderState
                .firstWhere((element) => element.id == id)
                .percent <
            checkWarning()) {
          return true;
        }
      } catch (e) {
        return true;
      }
      return false;
    }
    // if(widget.tasks != null){
    //   print(widget.tasks.monitorItemController.length);
    // }
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount:
          widget.tasks == null ? 0 : widget.tasks.monitorItemController.length,
      itemBuilder: (BuildContext context, int index) => getPercentageItems(
                  widget.tasks.monitorItemController[index].startAssign
                      .assignPersonnel.id) &&
              (widget.tasks.monitorItemController[index].startAssign
                      .assignPersonnel.name
                      .contains(p.search) ||
                  widget.tasks.monitorItemController[index].startAssign
                      .assignPersonnel.cutCode
                      .contains(p.search) ||
                  widget.tasks.monitorItemController[index].startAssign.p.name
                      .contains(p.search))
          ? SizedBox(
              height: 250,
              child: BlocBuilder(
                  cubit: widget
                      .tasks.monitorItemController[index].timerPersonnelCubit,
                  builder: (BuildContext context, TimerPersonnelState state) {
                    // if(){
                    //   return Container();
                    // }
                    return ChangeNotifierProvider.value(
                      value: p,
                      child: MonitorCard(
                        maxWidth: 400,
                        monitorItemController:
                            widget.tasks.monitorItemController[index],
                      ),
                    );
                  }),
            )
          : Container(),
    );
  }
}
