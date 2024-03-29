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

class MonitorCard extends StatefulWidget {
  final double maxWidth;
  final MonitorItemController monitorItemController;
  final String serverPlay;
  final String serverPlayDateTime;
  final String serverRemainingTime;

  MonitorCard(
      {this.maxWidth = 300,
      this.monitorItemController,
      this.serverPlay,
      this.serverPlayDateTime,
      this.serverRemainingTime});

  @override
  State<StatefulWidget> createState() =>
      _MonitorCardState(cubit: monitorItemController);
}

class _MonitorCardState extends State<MonitorCard> {
  final MonitorItemController cubit;
  _MonitorCardState({this.cubit});
  // String playDateTime;

  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    print(widget.serverPlayDateTime);
    String id = cubit.startAssign.assignPersonnel.id;
    // if (playDateTime == null) {
    //   playDateTime = cubit.startAssign.assignPersonnel.playDateTime;
    // }
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
          String dateTime = DateTime.now().toString().substring(0, 19);
          String update = Update.playMonitorCard(
              play: '1',
              id: cubit.startAssign.assignPersonnel.id,
              dateTime: dateTime);
          String body = await MyRequest.simpleQueryRequest(
              'stockpile/runQuery.php', update);
          if (body.trim() == "OK") {
            // setState(() {
            //   playDateTime = dateTime;
            // });
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
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              child: cubit.startAssign.assignPersonnel.cutCode.contains(',')? Text('دسته',style: theme.textTheme.headline6,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,):Text(
                '#' + cubit.startAssign.assignPersonnel.cutCode,
                style: theme.textTheme.headline6,
                textDirection: TextDirection.ltr,
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
                                'فعالیت ها : ' +
                                    cubit.startAssign.assignPersonnel
                                        .currentTask +
                                    '/' +
                                    cubit.startAssign.assignPersonnel.totalTask,
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
                          serverPlay: widget.serverPlay,
                          serverPlayDateTime: widget.serverPlayDateTime,
                          assignPersonnel: cubit.startAssign.assignPersonnel,
                          playDateTime: widget.serverPlayDateTime,
                          remainingTime: widget.serverRemainingTime,

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
  final String playDateTime;
  TimerControllerProvider p;
  final String serverPlay;
  final String serverPlayDateTime;
  String s;
  int x;
  final String remainingTime;
  MyCircularProgress(
      {this.assignPersonnel,
      this.cubit,
      this.x,
      this.pause,
      this.pauseAll,
      this.s,
      this.playDateTime,
      this.p,
      this.serverPlayDateTime,
      this.serverPlay,
      this.remainingTime});

  createState() =>
      _MyCircularProgressState(assignPersonnel: assignPersonnel, cubit: cubit);
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  final AssignPersonnel assignPersonnel;
  final TimerPersonnelCubit cubit;
  Duration total;
  DateTime startDateTime;

  _MyCircularProgressState({this.assignPersonnel, this.cubit});

  playFromServer()async{
    await Future.delayed(Duration(milliseconds: 250));
    widget.p.playOne(widget.assignPersonnel.id);
  }
  pauseFromServer()async{
    await Future.delayed(Duration(milliseconds: 250));
    widget.p.pauseOne(widget.assignPersonnel.id);
  }


  @override
  void didUpdateWidget(covariant MyCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    // // print(widget.serverPlayDateTime);
    if (widget.serverPlay == '1' && widget.serverPlayDateTime != null) {
      // print("OK");
      // startDateTime = DateTime.parse(widget.serverPlayDateTime).add(Duration(
      //     seconds: int.parse(widget.remainingTime) * (-1)));
      if (widget.pause == true) {
        playFromServer();
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {


        // });
      }
    }else if (widget.serverPlay == '0'){
      if (widget.pause == false) {
        pauseFromServer();
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   widget.p.pauseOne(widget.assignPersonnel.id);
        // });
      }

    }

    if ((oldWidget.pause != widget.pause && widget.pause == false)) {
      if (widget.serverPlayDateTime == null) {
        startDateTime = DateTime.now()
            .add(Duration(seconds: cubit.state.plus.inSeconds * (-1)));
        print("here4");
      } else {
        // print(assignPersonnel.playDateTime);
        startDateTime = DateTime.parse(widget.serverPlayDateTime)
            .add(Duration(seconds: cubit.state.plus.inSeconds * (-1)));
        print("here5");
      }
      updater(startDateTime, total, cubit, assignPersonnel.play);
    } else {}
  }


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
      print("here");
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
        widget.assignPersonnel.remainingTime = plus.inSeconds.toString();
        cubit.updatePercent(total.inSeconds, mines, plus, p);
      } else {
        // plus = Duration(seconds: plus.inSeconds + 1);
        plus = Duration(seconds: now.difference(startDateTime).inSeconds);
        // double p = (mines.inSeconds / total.inSeconds) * 100;
        double p = 0;
        widget.p.update(TimerControllerProviderState(
            x: plus.inSeconds,
            id: assignPersonnel.id,
            pause: widget.pause,
            percent: p,
            s: widget.pause == true ? '0' : '1'));
        widget.assignPersonnel.remainingTime = plus.inSeconds.toString();
        cubit.updatePercent(total.inSeconds, Duration(seconds: 0), plus, p);
      }
      if (widget.p.timerControllerProviderState
              .firstWhere((element) => element.id == assignPersonnel.id)
              .s ==
          '0') {
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    total = Duration(seconds: int.parse(assignPersonnel.time));
    if (assignPersonnel.remainingTime == '0' &&
        assignPersonnel.playDateTime == null) {
      try {
        startDateTime = DateTime.parse(assignPersonnel.startDateTime);
        print("here3");
      } catch (e) {
        startDateTime = DateTime.now();
      }
    } else if (assignPersonnel.playDateTime != null) {
      // print("here");
      // print(widget.assignPersonnel.remainingTime);
      print("here1");
      startDateTime = DateTime.parse(assignPersonnel.playDateTime).add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    } else {
      print("here2");
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
          cubit.updatePercent(total.inSeconds, mines, plus, p);
        } else {
          plus = Duration(seconds: plus.inSeconds);
          double p = (mines.inSeconds / total.inSeconds) * 100;
          widget.p.update(TimerControllerProviderState(
              x: plus.inSeconds,
              id: assignPersonnel.id,
              pause: widget.pause,
              percent: p,
              s: widget.pause == true ? '0' : '1'));
          cubit.updatePercent(total.inSeconds, mines, plus, p);
        }
      });
    }
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
