
import 'package:flutter/cupertino.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/publish_manager/task_project_pieces.dart';

class NewTaskPageProvider extends ChangeNotifier{

  TaskPiecesProject p ;
  List<Task> tasks = [];
  List<TaskChecksAssign> taskChecksAssign = [];

  NewTaskPageProvider(List <Task> tasks){
    this.tasks = tasks;
    tasks.forEach((element) {
      taskChecksAssign.add(TaskChecksAssign(check: false,task: element));
    });
  }

  void updatePiecesProject(TaskPiecesProject p){
    this.p = p;
    notifyListeners();
  }

  void updateTaskCheck(bool check , String id){
    List<TaskChecksAssign> t = [];
    taskChecksAssign.forEach((element) {
      if(element.task.id == id){
        t.add(TaskChecksAssign(task: element.task,check: check));
      }else{
        t.add(element);
      }
    });
    taskChecksAssign = t;
    notifyListeners();
  }
}

class TaskChecksAssign{
  Task task;
  bool check;
  TaskChecksAssign({this.task,this.check});
}