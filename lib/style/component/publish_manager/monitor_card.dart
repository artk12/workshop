import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'CircleProgress.dart';

// ignore: must_be_immutable
class MonitorCard extends StatefulWidget {
  final double maxWidth;
  final MonitorItemController monitorItemController;

  MonitorCard({this.maxWidth = 300, this.monitorItemController});

  @override
  State<StatefulWidget> createState() =>
      _MonitorCardState(cubit: monitorItemController);
}

class _MonitorCardState extends State<MonitorCard> {
  final MonitorItemController cubit;
  _MonitorCardState({this.cubit});

  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    String id = cubit.startAssign.assignPersonnel.id;
    bool pause = p.getPause(id);
    if (pause == null) {
      pause = cubit.startAssign.assignPersonnel.play == '0' ? true : false;
    }

    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () async {

        pause = !pause;
        String dateTime = DateTime.now().toString().substring(0, 19);
        MyShowSnackBar.showSnackBar(context, 'کمی صبر کنید...');
        if (pause) {
          int remainingTime = cubit.timerPersonnelCubit.state.plus.inSeconds;
          double level = 0;
          if (cubit.startAssign.p.level == 'حرفه ای') {
            level = 1.5;
          } else if (cubit.startAssign.p.level == 'تازه کار') {
            level = 1.0;
          } else {
            level = 0.5;
          }
          double currentScore = remainingTime * level;
          double score =
              (double.parse(cubit.startAssign.assignPersonnel.time) * level) -
                  currentScore;
          String update = Update.pauseMonitorCard(
              pauseDateTime: dateTime,
              id: cubit.startAssign.assignPersonnel.id,
              play: '0',
              score: score.toString(),
              remainingTime: remainingTime.toString());
          String body = await MyRequest.simpleQueryRequest(
              'stockpile/runQuery.php', update);
          if (body.trim() == 'OK') {
            MyShowSnackBar.hideSnackBar(context);
            try {
              p.pauseOne(id);
            } catch (e) {
              print("something wrong");
            }
          } else {
            pause = !pause;
            MyShowSnackBar.showSnackBar(
                context, 'لطفا وضعیت اینترنت خود را چک کنید.');
          }
        } else {
          String update = Update.playMonitorCard(
              play: '1', id: cubit.startAssign.assignPersonnel.id);
          String body = await MyRequest.simpleQueryRequest(
              'stockpile/runQuery.php', update);
          if (body.trim() == "OK") {
            MyShowSnackBar.hideSnackBar(context);
            try {
              p.playOne(id);
            } catch (e) {
              print("something wrong");
            }
          } else {
            pause = !pause;
            MyShowSnackBar.showSnackBar(
                context, 'لطفا وضعیت اینترنت خود را چک کنید.');
          }
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: widget.maxWidth, minWidth: 150),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: Text(
                '#' + cubit.startAssign.assignPersonnel.cutCode,
                style: theme.textTheme.headline6,
                textAlign: TextAlign.end,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(MyRequest.baseUrl +
                              'profile/profile_personnel.png'),
                          radius: 45,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.startAssign.p.name,
                                style: theme.textTheme.headline4,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                cubit.startAssign.assignPersonnel.name,
                                style: theme.textTheme.headline5,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                'فعالیت ها : ' + cubit.startAssign.assignPersonnel.currentTask+'/'+cubit.startAssign.assignPersonnel.totalTask,
                                style: theme.textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCircularProgress(
                          // pauseAll: currentPause,
                          assignPersonnel: cubit.startAssign.assignPersonnel,
                          // pause: p.getPause(cubit.startAssign.assignPersonnel.id),
                          pause: pause,
                          p: p,
                          s: p.getString(id),
                          cubit: cubit.timerPersonnelCubit,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyCircularProgress extends StatefulWidget {
  final AssignPersonnel assignPersonnel;
  final bool pause;
  final bool pauseAll;
  final TimerPersonnelCubit cubit;
  TimerControllerProvider p;
  String s;
  int x;
  MyCircularProgress(
      {this.assignPersonnel,
      this.cubit,
      this.x,
      this.pause,
      this.pauseAll,
      this.s,
      this.p});

  createState() =>
      _MyCircularProgressState(assignPersonnel: assignPersonnel, cubit: cubit);
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  final AssignPersonnel assignPersonnel;
  final TimerPersonnelCubit cubit;
  Duration total;
  DateTime startDateTime;

  _MyCircularProgressState({this.assignPersonnel, this.cubit});

  void updater(DateTime startDateTime, Duration total,
      TimerPersonnelCubit cubit, String play) async {
    Duration plus = Duration(seconds: 0);
    DateTime endDateTime =
        startDateTime.add(Duration(seconds: total.inSeconds));
    Duration mines = total;

    while (true) {
      await Future.delayed(Duration(seconds: 1));
      if (widget.pause) {
        break;
      }
      DateTime now = DateTime.now();
      if (endDateTime.difference(now).inSeconds >= 0) {
        mines = Duration(seconds: endDateTime.difference(now).inSeconds);
        plus = Duration(seconds: now.difference(startDateTime).inSeconds);
        double p = (mines.inSeconds / total.inSeconds) * 100;
        widget.p.update(TimerControllerProviderState(
            x: plus.inSeconds,
            id: assignPersonnel.id,
            pause: widget.pause,
            percent: p,
            s: widget.pause == true ? '0' : '1'));
        cubit.updatePercent(total.inSeconds, mines, plus,p);
      } else {
        plus = Duration(seconds: plus.inSeconds + 1);
        double p = (mines.inSeconds / total.inSeconds) * 100;
        widget.p.update(TimerControllerProviderState(
            x: plus.inSeconds,
            id: assignPersonnel.id,
            pause: widget.pause,
            percent: p,
            s: widget.pause == true ? '0' : '1'));
        cubit.updatePercent(total.inSeconds, mines, plus,p);
      }
      if (widget.p.timerControllerProviderState
              .firstWhere((element) => element.id == assignPersonnel.id)
              .s == '0') {
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    total = Duration(seconds: int.parse(assignPersonnel.time));

    if (assignPersonnel.remainingTime == '0') {
      try {
        startDateTime = DateTime.parse(assignPersonnel.startDateTime);
      } catch (e) {
        startDateTime = DateTime.now();
      }
    } else {
      startDateTime = DateTime.now().add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    }

    if (!widget.pause) {
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => updater(startDateTime, total, cubit, assignPersonnel.play));
    } else {
      Duration plus = Duration(seconds: 0);
      DateTime endDateTime =
          startDateTime.add(Duration(seconds: total.inSeconds));
      Duration mines = total;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        DateTime now = DateTime.now();
        if (endDateTime.difference(now).inSeconds >= 0) {
          mines = Duration(seconds: endDateTime.difference(now).inSeconds);
          plus = Duration(seconds: now.difference(startDateTime).inSeconds);
          double p = (mines.inSeconds / total.inSeconds) * 100;
          widget.p.update(TimerControllerProviderState(
              x: plus.inSeconds,
              id: assignPersonnel.id,
              pause: widget.pause,
              percent: p,
              s: widget.pause == true ? '0' : '1'));
          cubit.updatePercent(total.inSeconds, mines, plus,p);
        } else {
          plus = Duration(seconds: plus.inSeconds + 1);
          double p = (mines.inSeconds / total.inSeconds) * 100;
          widget.p.update(TimerControllerProviderState(
              x: plus.inSeconds,
              id: assignPersonnel.id,
              pause: widget.pause,
              percent: p,
              s: widget.pause == true ? '0' : '1'));
          cubit.updatePercent(total.inSeconds, mines, plus,p);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant MyCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pause != widget.pause && widget.pause == false) {
      startDateTime = DateTime.now()
          .add(Duration(seconds: cubit.state.plus.inSeconds * (-1)));
      updater(startDateTime, total, cubit, assignPersonnel.play);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme(context) => Theme.of(context);
    return Container(
      height: 180,
      width: 180,
      child: BlocBuilder(
        cubit: cubit,
        builder: (BuildContext context, TimerPersonnelState state) =>
            CustomPaint(
          foregroundPainter: CircleProgress(
              currentProgress: state.currentPercent, color: state.color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('${state.t1}',
                    textAlign: TextAlign.center,
                    style: theme(context).textTheme.headline1),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text('${state.t2}',
                    textAlign: TextAlign.center,
                    style: theme(context).textTheme.headline6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}