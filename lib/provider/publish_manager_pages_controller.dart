import 'package:flutter/foundation.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/publishManager/assign_personnel.dart';
import 'package:workshop/bloc/publishManager/assign_task.dart';
import 'package:workshop/bloc/publishManager/groupTaskAssign.dart';

const String MONITOR = "MONITORING";
const String DASHBOARD = "DASHBOARD";
const String NOTIFICATION = "NOTIFICATION";
const String ASSIGN = "ASSIGN";
const String TASKS = "TASKS";
const String LOG = "LOG";

class PublishManagerPageController extends ChangeNotifier {
  String page = DASHBOARD;
  //TODO THIS
  int pageView = 2;
  AssignTaskCubit assignTaskCubit =
      AssignTaskCubit(AssignTaskState(assignTaskUpdate: []));
  AssignPersonnelCubit assignPersonnelCubit =
      new AssignPersonnelCubit(AssignPersonnelState(assignments: []));
  GroupTaskAssignCubit groupTaskAssignCubit = new GroupTaskAssignCubit(GroupTaskAssignState(list: []));
  void changePage(String page) {
    this.page = page;
    notifyListeners();
  }
}
