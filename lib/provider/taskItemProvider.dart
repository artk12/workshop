import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';

class TaskItemProviderState {
  bool check;
  String id;
  TimerPersonnelCubit cubit;
  bool isDone;
  TaskItemProviderState({this.check, this.id,this.isDone = false}){
    this.cubit = TimerPersonnelCubit(TimerPersonnelState(lastPercent: 100,t2: '',t1: '',color: Colors.transparent,currentPercent: 100));
  }
}

class TaskItemProvider extends ChangeNotifier {
  List<TaskItemProviderState> checks = [];
  List<AssignPersonnel> tasks = [];
  bool firstTime = true;
  Color color = Colors.green.withOpacity(0.1);

  TaskItemProvider(List<AssignPersonnel> tasks) {
    this.tasks = tasks;
    tasks.forEach((element) {
      checks.add(TaskItemProviderState(id: element.id, check: false));
    });
  }

  void submitTask(String id) {
    int index = checks.indexWhere((element) => element.id == id);
    checks[index].isDone = true;
    checks[index].check = false;
    firstTime = true;
    color = Colors.black.withOpacity(0.3);
    notifyListeners();
  }

  void update(bool check, String id) {
    checks.firstWhere((element) => element.id == id).check = check;
    notifyListeners();
  }

  set taskItemCheckSetter(List<TaskItemProviderState> list) {
    this.checks = list;
  }

  void updateColor(Color color) {
    this.color = color;
    notifyListeners();
  }

  void updateFirstTime(bool check) {
    this.firstTime = check;
  }
}
