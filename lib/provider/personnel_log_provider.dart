
import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';

class PersonnelLogProvider extends ChangeNotifier{
  List<AssignmentLog> a = [];

  set assignmentLogSetter(List<AssignmentLog> a){
    this.a = a;
  }

}