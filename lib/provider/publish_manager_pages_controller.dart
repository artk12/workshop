import 'package:flutter/foundation.dart';
import 'package:workshop/bloc/publishManager/assign_personnel.dart';
import 'package:workshop/bloc/publishManager/assign_task.dart';

const String MONITOR = "MONITORING";
const String DASHBOARD = "DASHBOARD";
const String NOTIFICATION = "NOTIFICATION";
const String ASSIGN = "ASSIGN";
const String TASKS = "TASKS";
const String LOG = "LOG";

class PublishManagerPageController extends ChangeNotifier {
  String page = DASHBOARD;
  int pageView = 0;
  AssignTaskCubit assignTaskCubit =
      AssignTaskCubit(AssignTaskState(assignTaskUpdate: []));
  AssignPersonnelCubit assignPersonnelCubit =
      new AssignPersonnelCubit(AssignPersonnelState(assignments: []));

  void changePage(String page) {
    this.page = page;
    notifyListeners();
  }
}
