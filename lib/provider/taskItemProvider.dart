import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:flutter/foundation.dart';

class TaskItemProviderState {
  bool check;
  String id;
  TimerPersonnelCubit cubit;
  bool isDone;
  bool isFirstTime;

  TaskItemProviderState(
      {this.check,
      this.id,
      this.isDone = false,
      this.isFirstTime = true,
      this.cubit}) {
    if (cubit == null) {
      this.cubit = TimerPersonnelCubit(TimerPersonnelState(
          lastPercent: 100,
          t2: '',
          t1: '',
          color: Colors.transparent,
          currentPercent: 100));
    }
  }
}

class TaskItemProvider extends ChangeNotifier {
  List<TaskItemProviderState> checks = [];
  List<AssignPersonnel> tasks = [];
  // bool firstTime = true;
  Color color = Colors.green.withOpacity(0.1);
  DateTime now;
  set taskSetter(List<AssignPersonnel> tasks) {
    // print("here4");
    print(tasks.length);
    if (this.tasks.isEmpty) {
      // print(tasks.length);
      // if(!listEquals(this.tasks, tasks)){
      this.tasks = tasks;
      tasks.forEach((element) {
        bool check = false;
        if (element.play == '1') {
          check = true;
        }
        checks.add(TaskItemProviderState(id: element.id, check: check));
      });
    } else if (isEquals(tasks) == false) {
      print("here");
      this.tasks = tasks;
      int index = -1;
      TaskItemProviderState current ;
      checks.forEach((element) {
        if (element.cubit.state.plus != null) {
          if (element.cubit.state.plus.inSeconds > 0 && element.check == true) {
            current = element;
          }
        }
      });
      // int index = checks.indexWhere((item) => item.id == element.id);
      checks.clear();
      tasks.forEach((element) {
        bool check = false;
        if (element.play == '1') {
          check = true;
        }
        if(current != null ){
          if(current.id == element.id && element.play == '1'){
            checks.add(current);
          }else{
            checks.add(TaskItemProviderState(
              id: element.id,
              check: check,
              isFirstTime: true,
            ));
          }
        }else{
          checks.add(TaskItemProviderState(
            id: element.id,
            check: check,
            isFirstTime: true,
          ));
        }
      });
      print('len '+checks.length.toString());
      // firstTime = true;
      notifyListeners();
    }
    // }
  }

  bool isEquals(List<AssignPersonnel> tasks) {
    bool check = true;
    if (tasks.length == this.tasks.length) {
      for (int i = 0; i < tasks.length; i++) {
        AssignPersonnel a = tasks[i];
        AssignPersonnel b = this.tasks[i];
        if (a.playDateTime != a.playDateTime || b.play != a.play) {
          check = false;
          break;
        }
      }
    } else {
      check = false;
    }
    return check;
  }

  TaskItemProvider() {
    now = DateTime.now();
    // this.tasks = tasks;
    // tasks.forEach((element) {
    //   checks.add(TaskItemProviderState(id: element.id, check: false));
    // });
  }

  void submitTask(String id) {
    int index = checks.indexWhere((element) => element.id == id);
    checks[index].isDone = true;
    checks[index].check = false;
    // checks[index].
    // firstTime = true;
    color = Colors.black.withOpacity(0.3);
    notifyListeners();
  }

  void update(bool check, String id) {
    checks.firstWhere((element) => element.id == id).check = check;
    checks.firstWhere((element) => element.id == id).isFirstTime = check;
    notifyListeners();
  }

  set taskItemCheckSetter(List<TaskItemProviderState> list) {
    this.checks = list;
  }

  void updateColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void updateFirstTime(bool check, String id) {
    int index = checks.indexWhere((element) => element.id == id);
    checks[index].isFirstTime = check;
    // this.firstTime = check;
  }

  bool getUpdateFirstTime(String id) {
    int index = checks.indexWhere((element) => element.id == id);
    return checks[index].isFirstTime;
  }
}
