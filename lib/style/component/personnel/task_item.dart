import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/personnel/dialog_submit.dart';
import 'package:workshop/personnel/my_progress.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class TaskItem extends StatefulWidget {
  final double maxWidth;
  final AssignPersonnel assignPersonnel;
  final int index;
  final int total;
  final TaskItemProvider provider;
  final User user;
  final ScoreCubit scoreCubit;
  final TimerPersonnelCubit cubit;

  TaskItem({
    this.maxWidth = 300,
    this.assignPersonnel,
    this.index,
    this.total,
    this.user,
    @required this.scoreCubit,
    this.provider,
    this.cubit,
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool stopServer;
  bool stop = false;
  String connection = "مشکل در اتصال به اینترنت ! ";
  @override
  Widget build(BuildContext context) {

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
          // MyShowSnackBar.showSnackBar(context, 'لطفا کمی صبر کنید...');
          String res = await MyRequest.startTask(id, taskName, widget.user.name,
              cutCode, personnelId, startDateTime);
          if (res.trim() == "OK") {
            await Future.delayed(Duration(milliseconds: 250));
            setState(() {
              stop = false;
            });
            await Future.delayed(Duration(milliseconds: 250));
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            widget.provider.update(true, widget.assignPersonnel.id);
          } else {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     duration: Duration(days: 1),
            //     content: Container(
            //       child: Row(
            //         children: [
            //           Expanded(
            //             child: Text(
            //               connection,
            //               style:
            //                   theme.textTheme.bodyText1.copyWith(fontSize: 14),
            //             ),
            //           ),
            //           TextButton(
            //             onPressed: () async {
            //               String res = await MyRequest.startTask(
            //                   id,
            //                   taskName,
            //                   widget.user.name,
            //                   cutCode,
            //                   personnelId,
            //                   startDateTime);
            //               if (res == "OK") {
            //                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //                 widget.provider.update(true, widget.assignPersonnel.id);
            //               }
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                 border: Border.all(color: Colors.white12, width: 1),
            //               ),
            //               padding: EdgeInsets.all(9),
            //               child: Text(
            //                 'امتحان مجدد',
            //                 style: theme.textTheme.bodyText1
            //                     .copyWith(fontSize: 14),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
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
              await Future.delayed(Duration(milliseconds: 250));
              double level = 1.5;
              double totalScore =
                  int.parse(widget.assignPersonnel.time) * level;
              double currentScore = widget.provider.checks[widget.index - 1]
                      .cubit.state.plus.inSeconds *
                  level;
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
              // MyShowSnackBar.showSnackBar(context, 'لطفا کمی صبر کنید...');
              String res = await MyRequest.submitTask(
                  id, score.toString(), year, month, day, warning);
              if (res.trim() == "OK") {
                try {
                  widget.provider.removeIds.add(widget.assignPersonnel.id);
                  // widget.provider.checks.where((element) => element)
                  // widget.provider.tasks.removeWhere((element) => element.id == widget.assignPersonnel.id);
                  await Future.delayed(Duration(milliseconds: 200));
                  widget.scoreCubit.updateScore(score);
                  widget.provider.submitTask(widget.assignPersonnel.id);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                } catch (e) {}
                // await Future.delayed(Duration(milliseconds: 200));
                // widget.provider.removeIds.add(widget.assignPersonnel.id);
                // widget.scoreCubit.updateScore(score);
                // widget.provider.submitTask(widget.assignPersonnel.id);
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
                                widget.provider
                                    .submitTask(widget.assignPersonnel.id);
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
                                          '${widget.index+widget.provider.removeIds.length}/${widget.total+widget.provider.removeIds.length}',
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
                                cubit: widget.cubit,
                                check: widget.provider.checks
                                    .firstWhere((element) => element.id == widget.assignPersonnel.id).check,
                                assignPersonnel: widget.assignPersonnel,
                                stopServer: widget.assignPersonnel.play == "0" ? true : false,
                                index: widget.index,
                                provider: widget.provider,
                                playDateTime: widget.assignPersonnel.playDateTime,
                                stop: stop,
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
