import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../time_format.dart';

class TimerPersonnelCubit extends Cubit<TimerPersonnelState> {
  TimerPersonnelCubit(TimerPersonnelState state) : super(state);

  void updatePercent(int total, Duration mines, Duration plus,double p) {
    // this.plus = plus;
    Color color;
    if (p > 50) {
      color = Colors.green;
    } else if (p <= 50 && p > 25) {
      color = Colors.amber;
    } else if (p <= 25) {
      color = Colors.red;
    }

    emit(TimerPersonnelState(
      currentPercent: p,
      lastPercent: state.lastPercent,
      plus: plus,
      t1: TimeFormat.timeFormatFromDuration(mines),
      t2: TimeFormat.timeFormatFromDuration(plus),
      color: color,
    ));
  }
}

class TimerPersonnelState {
  double currentPercent;
  double lastPercent;
  String t1;
  String t2;
  Color color;
  Duration plus;
  TimerPersonnelState(
      {this.currentPercent,
      this.lastPercent = 100,
      this.plus,
      this.color = Colors.green,
      this.t1 = '',
      this.t2 = ''});
}
