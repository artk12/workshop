import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/style/component/personnel/CircleProgress.dart';

class MyCircularProgress extends StatefulWidget {
  final AssignPersonnel assignPersonnel;
  final bool check;

  // final TimerPersonnelCubit cubit;
  final bool stopServer;
  final bool stop;
  final TaskItemProvider provider;
  final int index;
  final TimerPersonnelCubit cubit;
  final String playDateTime;

  // final int i;
  MyCircularProgress({
    this.assignPersonnel,
    this.check,
    this.provider,
    this.index,
    this.stopServer,
    this.cubit,
    this.playDateTime,
    this.stop,
    // this.i,
  });

  createState() => _MyCircularProgressState(
        assignPersonnel: assignPersonnel,
      );
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  final AssignPersonnel assignPersonnel;

  // final TimerPersonnelCubit cubit;
  // final int index;
  Duration total;
  DateTime startDateTime;
  bool test = false;
  String id;

  // TimerPersonnelCubit cubit;
  // bool stop = false;

  _MyCircularProgressState({this.assignPersonnel});

  void updater(DateTime startDateTime, Duration total, String play) async {
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
        widget.cubit.updatePercent(total.inSeconds, mines, plus, p);
      } else {
        plus = Duration(seconds: now.difference(startDateTime).inSeconds);
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
        widget.cubit
            .updatePercent(total.inSeconds, Duration(seconds: 0), plus, p);
      }
      if (!widget.check || widget.stop) {
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
    if (assignPersonnel.remainingTime == '0' && widget.playDateTime == null) {
      try {
        startDateTime = DateTime.parse(assignPersonnel.startDateTime);
      } catch (e) {
        startDateTime = DateTime.now();
      }
    } else if (widget.playDateTime != null) {
      startDateTime = DateTime.parse(widget.playDateTime).add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    } else {
      startDateTime = DateTime.now().add(Duration(
          seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    }
    startDateTime = now.add(Duration(
        seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
    plus = Duration(seconds: 0);
    endDateTime = startDateTime.add(Duration(seconds: total.inSeconds + 1));
    mines = total;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.cubit != null) {
      if (widget.check && widget.provider.getUpdateFirstTime(id)) {
        if (widget.playDateTime != null) {
          DateTime d = DateTime.parse(widget.playDateTime).add(Duration(
              seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
          startDateTime = d;
        } else {
          startDateTime = DateTime.now().add(Duration(
              seconds: int.parse(widget.assignPersonnel.remainingTime) * (-1)));
        }
        widget.provider.updateFirstTime(false, id);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => updater(
            startDateTime,
            total,
            assignPersonnel.play,
          ),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) {
            if (widget.provider.getUpdateFirstTime(id)) {
              widget.provider.updateFirstTime(false, id);
              now = DateTime.now();
              if (endDateTime.difference(now).inSeconds >= 0) {
                startDateTime = now.add(Duration(
                    seconds: int.parse(widget.assignPersonnel.remainingTime) *
                        (-1)));
                DateTime endDateTime =
                    startDateTime.add(Duration(seconds: total.inSeconds));
                mines =
                    Duration(seconds: endDateTime.difference(now).inSeconds);
                plus =
                    Duration(seconds: now.difference(startDateTime).inSeconds);
                double p = (mines.inSeconds / total.inSeconds) * 100;
                widget.cubit.updatePercent(total.inSeconds, mines, plus, p);
              } else {
                startDateTime = DateTime.now().add(Duration(
                    seconds: int.parse(widget.assignPersonnel.remainingTime) *
                        (-1)));
                plus =
                    Duration(seconds: now.difference(startDateTime).inSeconds);
                // plus = Duration(seconds: plus.inSeconds);
                // double p = (mines.inSeconds / total.inSeconds) * 100;
                double p = 0;
                widget.cubit.updatePercent(
                    total.inSeconds, Duration(seconds: 0), plus, p);
              }
            } else {}
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme(context) => Theme.of(context);
    return widget.provider.checks
                .indexWhere((element) => element.id == assignPersonnel.id) ==
            -1
        ? Container(
            height: 100,
            width: 100,
            color: Colors.white,
          )
        : Container(
            height: 140,
            width: 140,
            child: widget.cubit == null
                ? Container()
                : BlocBuilder(
                    cubit: widget.cubit,
                    builder:
                        (BuildContext context, TimerPersonnelState state) =>
                            CustomPaint(
                      foregroundPainter: CircleProgress(
                          currentProgress: state.currentPercent,
                          color: state.color),
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
