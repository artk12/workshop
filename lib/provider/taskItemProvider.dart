import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';

class TaskItemProviderState {
  bool check;
  String id;
  TimerPersonnelCubit cubit;
  bool isDone;
  bool isFirstTime;
  int index;

  TaskItemProviderState(
      {this.check,
      this.id,
      this.isDone = false,
      this.isFirstTime = true,
      this.index,
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
  RefreshProvider refreshProvider;
  List<String> removeIds = [];
  bool change = false;
  int count = 0;

  Color color = Colors.green.withOpacity(0.1);
  DateTime now;
  set taskSetter(List<AssignPersonnel> tasks) {
    print("${tasks.length} "+" ${this.tasks.length}");
    if (this.tasks.isEmpty) {
      this.tasks = tasks;
      tasks.forEach((element) {
        bool check = false;
        if (element.play == '1') {
          check = true;
        }
        checks.add(TaskItemProviderState(id: element.id, check: check));
      });
    } else if (isEquals(tasks) == false) {
      this.tasks = tasks;
      TaskItemProviderState current;
      checks.forEach((element) {
        if (element.cubit.state.plus != null) {
          if (element.cubit.state.plus.inSeconds > 0 && element.check == true) {
            current = element;
          }
        }
      });
      // int index = checks.indexWhere((item) => item.id == element.id);
      checks.clear();
      int counter = 0;
      tasks.forEach((element) {

        bool check = false;
        if (element.play == '1') {
          check = true;
        }
        if (false) {
          if (current.id == element.id && element.play == '1') {
            checks.add(current);
          } else {
            checks.add(TaskItemProviderState(
              id: element.id,
              check: check,
              isFirstTime: true,
            ));
          }
        } else {
          checks.add(TaskItemProviderState(
            id: element.id,
            check: check,
            isFirstTime: true,
            index: counter
          ));
        }
        counter++;
      });
    } else if ((tasks.length != 0 && tasks.length < this.tasks.length)) {
      checks.clear();
      this.tasks.clear();
      notifyListeners();
      // this.tasks = tasks;
      // // List<TaskItemProviderState> t = [];
      // // checks.forEach((element) {
      // //   element.cubit.close();
      // // });
      // checks.clear();
      // int counter = 0;
      // tasks.forEach((element) {
      //   checks.add(TaskItemProviderState(
      //       isDone: false,
      //       isFirstTime: true,
      //       id: element.id,
      //       check: false,
      //       index: counter,
      //       cubit: TimerPersonnelCubit(TimerPersonnelState(
      //           lastPercent: 100,
      //           t2: '',
      //           t1: '',
      //           color: Colors.transparent,
      //           currentPercent: 100))));
      //   counter++;
      //   // checks.add(t.firstWhere((item) => item.id == element.id));
      // });
      // change = true;
      // notifyListeners();
    }
  }

  bool isEquals(List<AssignPersonnel> tasks) {
    bool check = true;
    if (tasks.length == this.tasks.length) {
      for (int i = 0; i < tasks.length; i++) {
        AssignPersonnel a = tasks[i];
        AssignPersonnel b = this.tasks[i];
        if (a.playDateTime != b.playDateTime || b.play != a.play) {
          check = false;
          break;
        }
      }
    } else if ((tasks.length > this.tasks.length)) {
      check = false;
    }
    // else if((tasks.length < this.tasks.length)){
    //   for (int i = 0; i < tasks.length; i++) {
    //     AssignPersonnel a = tasks[i];
    //     AssignPersonnel b = this.tasks.firstWhere((element) => element.id == a.id);
    //     if (a.playDateTime != b.playDateTime || b.play != a.play) {
    //       check = false;
    //       break;
    //     }
    //   }
    // }
    return check;
  }

  TaskItemProvider({this.refreshProvider}) {
    now = DateTime.now();
    // this.tasks = tasks;
    // tasks.forEach((element) {
    //   checks.add(TaskItemProviderState(id: element.id, check: false));
    // });
  }

  void submitTask(String id) {
    // print("remove id $id");
    // checks.removeWhere((element) => element.id == id);
    // print(tasks.length);
    // this.tasks.removeWhere((element) => element.id == id);
    // print(tasks.length);
    int index = checks.indexWhere((element) => element.id == id);
    checks[index].isDone = true;
    checks[index].check = false;
    // checks[index].cubit.close();

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
    if (index != -1) {
      checks[index].isFirstTime = check;
    }
    // this.firstTime = check;
  }

  bool getUpdateFirstTime(String id) {
    int index = checks.indexWhere((element) => element.id == id);
    if (index == -1) {
      return false;
    } else
      return checks[index].isFirstTime;
  }
}
