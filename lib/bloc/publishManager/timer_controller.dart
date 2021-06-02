import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class TimerStreamer {
  List<MonitorItemController> monitorItemController = [];

  TimerStreamer({this.monitorItemController});

  void pauseAll(BuildContext context, TimerControllerProvider p) async {
    List<Map> mapList = [];
    String dateTime = DateTime.now().toString().substring(0, 19);
    monitorItemController.forEach((element) {
      TimerControllerProviderState t = p.timerControllerProviderState
          .firstWhere(
              (item) => item.id == element.startAssign.assignPersonnel.id);
      if (t.pause == false) {
        Map<String, String> map = {};
        int remainingTime;
        try {
          remainingTime = t.x - 1;
        } catch (e) {
          remainingTime = 0;
        }
        double level = 0;
        if (element.startAssign.p.level == 'حرفه ای') {
          level = 1.5;
        } else if (element.startAssign.p.level == 'تازه کار') {
          level = 1.0;
        } else {
          level = 0.5;
        }

        double currentScore = remainingTime * level;
        double score =
            (double.parse(element.startAssign.assignPersonnel.time) * level) -
                currentScore;
        print(remainingTime);
        map['play'] = '0';
        map['remainingTime'] = remainingTime.toString();
        map['id'] = element.startAssign.assignPersonnel.id;
        map['pauseDateTime'] = dateTime;
        map['score'] = score.toString();

        mapList.add(map);
      }
    });
    if (mapList.isNotEmpty) {
      String json = jsonEncode(mapList);
      print(json);
      MyShowSnackBar.showSnackBar(context, 'کمی صبر کنید...');
      String body = await MyRequest.pauseAllRequest(json);
      print(body);
      if (body.trim().contains('OK') && body != 'not ok') {
        print('here');
        MyShowSnackBar.hideSnackBar(context);
        p.pauseAll();
      } else {
        MyShowSnackBar.showSnackBar(
            context, "لطفا وضعیت اینترنت خودرا چک کنید.");
      }
    }
  }

  void playAll(TimerControllerProvider p, BuildContext context) async {
    MyShowSnackBar.showSnackBar(context, "کمی صبرکنید...");
    String query = Update.playAllMonitorCard();
    String res =
        await MyRequest.simpleQueryRequest('stockpile/runQuery.php', query);
    if (res != "not ok") {
      MyShowSnackBar.hideSnackBar(context);
      p.playAll();
    } else {
      MyShowSnackBar.showSnackBar(context, "لطفا وضعیت اینترنت خودرا چک کنید.");
    }
  }
}

class MonitorItemController {
  StartAssign startAssign;
  TimerPersonnelCubit timerPersonnelCubit;
  bool pause;

  MonitorItemController(
      {this.timerPersonnelCubit, this.startAssign, this.pause = false}) {
    if (timerPersonnelCubit == null) {
      this.timerPersonnelCubit =
          TimerPersonnelCubit(TimerPersonnelState(currentPercent: 100));
    }
  }
}
