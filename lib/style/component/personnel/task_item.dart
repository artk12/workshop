import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/personnel/dialog_submit.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/personnel/CircleProgress.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class TaskItem extends StatefulWidget {
  final double maxWidth;
  final AssignPersonnel assignPersonnel;
  final int index;
  final int total;
  final TaskItemProvider provider;
  final User user;
  final ScoreCubit scoreCubit;

  TaskItem(
      {this.maxWidth = 300,
      this.assignPersonnel,
      this.index,
      this.total,
      this.user,
      @required this.scoreCubit,
      this.provider});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool stop ;
  String connection = "مشکل در اتصال به اینترنت ! ";

  @override
  void initState() {
    stop = widget.assignPersonnel.play == "0" ? true : false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // stop = widget.assignPersonnel.play == "0" ? true : false;

    ThemeData theme = Theme.of(context);
    int indexProvider =
        widget.provider.checks.indexWhere((element) => element.check == true);

    return GestureDetector(
      onTap: () async {
        if (indexProvider == -1) {
          String id = widget.assignPersonnel.id;
          String personnelId = widget.assignPersonnel.personnelId;
          String cutCode = widget.assignPersonnel.cutCode;
          String taskName = widget.assignPersonnel.name;
          String startDateTime = DateTime.now().toString().substring(0, 19);
          MyShowSnackBar.showSnackBar(context, 'لطفا کمی صبر کنید...');
          String res = await MyRequest.startTask(id, taskName, widget.user.name, cutCode, personnelId, startDateTime);
          if (res.trim() == "OK") {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            widget.provider.update(true, widget.assignPersonnel.id);
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(days: 1),
                content: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          connection,
                          style: theme.textTheme.bodyText1.copyWith(fontSize: 14),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          String res = await MyRequest.startTask(id, taskName, widget.user.name, cutCode, personnelId, startDateTime);
                          if (res == "OK") {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            widget.provider.update(true, widget.assignPersonnel.id);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white12, width: 1),
                          ),
                          padding: EdgeInsets.all(9),
                          child: Text(
                            'امتحان مجدد',
                            style: theme.textTheme.bodyText1
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        } else {
          if (widget.provider.checks[indexProvider].id ==
              widget.assignPersonnel.id) {
            String res = await showDialog(
                context: context,
                builder: (BuildContext context) => SubmitDialog(
                    assignPersonnel: widget.assignPersonnel,
                    timerPersonnel:
                        widget.provider.checks[widget.index - 1].cubit));
            if (res == "OK") {
              await Future.delayed(Duration(milliseconds: 250));
              setState(() {
                stop = true;
              });
              double level = 1.5;
              double totalScore = int.parse(widget.assignPersonnel.time) * level;
              double currentScore = widget.provider.checks[widget.index - 1].cubit.state.plus.inSeconds * level;
              double score = totalScore - currentScore;
              String warning = '0';
              DateTime now = DateTime.now();
              String year = now.year.toString();
              String month = now.month.toString();
              String day = now.day.toString();
              String id = widget.assignPersonnel.id;
              if (score < 0) {
                warning = '1';
              }
              MyShowSnackBar.showSnackBar(context, 'لطفا کمی صبر کنید...');
              String res = await MyRequest.submitTask(
                  id, score.toString(), year, month, day, warning);
              if (res.trim() == "OK") {
                try{
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }catch(e){}
                await Future.delayed(Duration(milliseconds: 200));
                widget.scoreCubit.updateScore(score);
                widget.provider.submitTask(widget.assignPersonnel.id);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(days: 1),
                    content: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            connection,
                            style: theme.textTheme.bodyText1
                                .copyWith(fontSize: 14),
                          )),
                          TextButton(
                            onPressed: () async {
                              setState(() {
                                connection =
                                    "در حال تلاش مجدد لطفا کمی صبر کنید...";
                              });
                              String res = await MyRequest.submitTask(id,
                                  score.toString(), year, month, day, warning);
                              print(res);
                              if (res.trim() == "OK") {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                widget.provider.submitTask(widget.assignPersonnel.id);
                                widget.scoreCubit.updateScore(score);
                              } else {
                                setState(() {
                                  connection = "مشکل در اتصال به اینترنت ! ";
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white12, width: 1),
                              ),
                              padding: EdgeInsets.all(9),
                              child: Text(
                                'امتحان مجدد',
                                style: theme.textTheme.bodyText1
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else {
              print("back button");
            }
          } else {
            MyShowSnackBar.showSnackBar(context,
                'تا اتمام فعالیت شروع شده نمیتوانید فعالیت دیگه را شروع کنید.');
          }
        }
      },
      child: BlocBuilder(
          cubit: widget.provider.checks[widget.index - 1].cubit,
          builder: (BuildContext context, TimerPersonnelState state) {
            return Container(
              constraints: BoxConstraints(
                  maxWidth: widget.maxWidth, minWidth: 150, maxHeight: 180),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: indexProvider != -1 &&
                        widget.provider.checks[indexProvider].id ==
                            widget.assignPersonnel.id
                    ? widget.provider.color
                    : Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.maxFinite,
                    child: Text(
                      '#' + widget.assignPersonnel.cutCode,
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
                                      widget.assignPersonnel.name,
                                      style: theme.textTheme.headline3,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'مقدار : ' +
                                          widget.assignPersonnel.number,
                                      style: theme.textTheme.headline5,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'فعالیت : ' +
                                          '${widget.index}/${widget.total}',
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
                                check: widget.provider.checks
                                    .firstWhere((element) =>
                                        element.id == widget.assignPersonnel.id)
                                    .check,
                                assignPersonnel: widget.assignPersonnel,
                                stop: stop,
                                index: widget.index,
                                provider: widget.provider,

                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class MyCircularProgress extends StatefulWidget {
  final AssignPersonnel assignPersonnel;
  final bool check;
  // final TimerPersonnelCubit cubit;
  final bool stop;
  final TaskItemProvider provider;
  final index;
  MyCircularProgress(
      {this.assignPersonnel, this.check, this.provider, this.index, this.stop});
  createState() =>
      _MyCircularProgressState(assignPersonnel: assignPersonnel, index: index);
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  final AssignPersonnel assignPersonnel;
  // final TimerPersonnelCubit cubit;
  final int index;
  Duration total;
  DateTime startDateTime;
  bool test = false;
  String id;
  // bool stop = false;

  _MyCircularProgressState({this.assignPersonnel, this.index});

  @override
  void dispose() {
    // if(!mounted){
    //   setState(() {
    //     stop = true;
    //   });
    // }
    super.dispose();
  }

  void updater(DateTime startDateTime, Duration total,
      TimerPersonnelCubit cubit, String play) async {
    Duration plus = Duration(seconds: 0);
    DateTime endDateTime =
        startDateTime.add(Duration(seconds: total.inSeconds + 1));
    Duration mines = total;
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      DateTime now = DateTime.now();
      if (endDateTime.difference(now).inSeconds >= 0) {

        mines = Duration(seconds: endDateTime.difference(now).inSeconds);
        plus = Duration(seconds: now.difference(startDateTime).inSeconds);
        double p = (mines.inSeconds / total.inSeconds) * 100;
        if (p <= 100 &&
            p > 50 &&
            widget.provider.color != Colors.green.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.green.withOpacity(0.1));
        } else if (p <= 50 &&
            p > 25 &&
            widget.provider.color != Colors.amber.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.amber.withOpacity(0.1));
        } else if (p <= 25 &&
            widget.provider.color != Colors.red.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.red.withOpacity(0.1));
        }
        cubit.updatePercent(total.inSeconds, mines, plus, p);
      } else {
        // plus = Duration(seconds: plus.inSeconds + 1);
        // print("here2");
        plus = Duration(seconds: now.difference(endDateTime).inSeconds);
        // double p = (mines.inSeconds / total.inSeconds) * 100;
        double p = 0;
        if (p <= 100 &&
            p > 50 &&
            widget.provider.color != Colors.green.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.green.withOpacity(0.1));
        } else if (p <= 50 &&
            p > 25 &&
            widget.provider.color == Colors.amber.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.amber.withOpacity(0.1));
        } else if (p <= 25 &&
            widget.provider.color != Colors.red.withOpacity(0.1)) {
          widget.provider.updateColor(Colors.red.withOpacity(0.1));
        }
        cubit.updatePercent(total.inSeconds, Duration(seconds: 0), plus, p);
      }
      // print(id + "${widget.stop}");
      if (widget.stop || !widget.check) {
        break;
      }
    }
  }
  Duration plus;
  DateTime endDateTime;
  Duration mines;
  DateTime now = DateTime.now();
  @override
  void initState() {
    id = widget.assignPersonnel.id;
    total = Duration(seconds: int.parse(assignPersonnel.time));
    // DateTime now = DateTime.now();
    if (assignPersonnel.remainingTime == '0' &&
        assignPersonnel.playDateTime == null) {
      try {
        startDateTime = DateTime.parse(assignPersonnel.startDateTime);
      } catch (e) {
        startDateTime = DateTime.now();
      }
    } else if (assignPersonnel.playDateTime != null) {
      startDateTime = DateTime.parse(assignPersonnel.playDateTime).add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    } else {
      startDateTime = DateTime.now().add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    }

    // if(assignPersonnel.id == "9"){
    //   print(" remaining time is" + widget.assignPersonnel.remainingTime+"  now is "+now.toString());
    //   print(now);
    // }
    startDateTime = now.add(Duration(
        seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));

    // if(assignPersonnel.id == "9"){
    //   print(startDateTime);
    // }

   plus = Duration(seconds: 0);
    endDateTime =
        startDateTime.add(Duration(seconds: total.inSeconds + 1));
    mines = total;
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     if (widget.provider.firstTime) {
    //       if (endDateTime.difference(now).inSeconds >= 0) {
    //         mines = Duration(seconds: endDateTime.difference(now).inSeconds);
    //         plus = Duration(seconds: now.difference(startDateTime).inSeconds);
    //         double p = (mines.inSeconds / total.inSeconds) * 100;
    //         widget.provider.checks[index - 1].cubit
    //             .updatePercent(total.inSeconds, mines, plus, p);
    //       } else {
    //         plus = Duration(seconds: now.difference(endDateTime).inSeconds);
    //         // plus = Duration(seconds: plus.inSeconds);
    //         // double p = (mines.inSeconds / total.inSeconds) * 100;
    //         double p = 0;
    //         widget.provider.checks[index - 1].cubit
    //             .updatePercent(total.inSeconds, Duration(seconds: 0), plus, p);
    //       }
    //     }
    //   },
    // );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    // print(widget.provider.getUpdateFirstTime(id));
    if (widget.check && widget.provider.getUpdateFirstTime(id)) {
      // if()
      if (assignPersonnel.playDateTime != null) {
        startDateTime = DateTime.parse(assignPersonnel.playDateTime).add(
            Duration(
                seconds: widget
                        .provider.checks[index - 1].cubit.state.plus.inSeconds *
                    (-1)));
      } else {
        startDateTime = DateTime.now().add(Duration(
            seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
      }
      widget.provider.updateFirstTime(false,id);
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => updater(
          startDateTime,
          total,
          widget.provider.checks[index - 1].cubit,
          assignPersonnel.play,
        ),
      );
    }else{
      WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
          if (widget.provider.getUpdateFirstTime(id)) {
            if (endDateTime.difference(now).inSeconds >= 0) {
              widget.provider.updateFirstTime(false, id);
              startDateTime = now.add(Duration(
                  seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
              mines = Duration(seconds: endDateTime.difference(now).inSeconds);
              plus = Duration(seconds: now.difference(startDateTime).inSeconds);
              double p = (mines.inSeconds / total.inSeconds) * 100;
              widget.provider.checks[index - 1].cubit
                  .updatePercent(total.inSeconds, mines, plus, p);
            } else {
              plus = Duration(seconds: now.difference(endDateTime).inSeconds);
              // plus = Duration(seconds: plus.inSeconds);
              // double p = (mines.inSeconds / total.inSeconds) * 100;
              double p = 0;
              widget.provider.checks[index - 1].cubit
                  .updatePercent(total.inSeconds, Duration(seconds: 0), plus, p);
            }
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme(context) => Theme.of(context);

    return Container(
      height: 140,
      width: 140,
      child: BlocBuilder(
        cubit: widget.provider.checks[index - 1].cubit,
        builder: (BuildContext context, TimerPersonnelState state) =>
            CustomPaint(
          foregroundPainter: CircleProgress(
              currentProgress: state.currentPercent, color: state.color),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(state.t1,
                    textAlign: TextAlign.center,
                    style: theme(context).textTheme.headline3),
              ),
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(state.t2,
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
