

import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/task.dart';

class AssignmentProvider extends ChangeNotifier{

  List<AssignmentTask> assignmentTask;
  AssignmentProvider(List<AssignmentTask> assignmentTask){
    this.assignmentTask = assignmentTask;
  }


}