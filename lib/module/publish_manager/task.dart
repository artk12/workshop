import 'package:workshop/module/publish_manager/personnel.dart';

class Task {
  String id;
  String name;
  String expertTime;
  String amateurTime;
  String internTime;
  String groupId;

  Task(
      {this.name, this.id, this.amateurTime, this.expertTime, this.internTime,this.groupId});

  factory Task.fromJson(Map map) {
    return Task(
      id: map['ID'],
      name: map['name'],
      amateurTime: map['amateur_time'],
      expertTime: map['expert_time'],
      internTime: map['intern_time'],
      groupId: map['group_id']
    );
  }
}

class TaskFolder{
  final String name;
  final String id;
  TaskFolder({this.name,this.id});

  factory TaskFolder.fromJson(Map map){
    return TaskFolder(id: map['ID'],name:map['name']);
  }
}


class FakeAssignmentTask {
  int number;
  String cutCode;
  String name;
  String expertTime;
  String amateurTime;
  String internTime;

  FakeAssignmentTask(int number, String internTime, String amateurTime,
      String expertTime, String name, String cutCode) {
    this.number = number;
    this.name = name;
    this.expertTime = expertTime;
    this.amateurTime = amateurTime;
    this.internTime = internTime;
    this.cutCode = cutCode;
  }

  static List<AssignmentTask> toOriginal(List<FakeAssignmentTask> a) {
    List<AssignmentTask> myList = [];
    a.forEach((element) {
      myList.add(AssignmentTask(
          element.number,
          element.internTime,
          element.amateurTime,
          element.expertTime,
          element.name,
          element.cutCode));
    });
    return myList;
  }

  static FakeAssignmentTask addOriginalToFake(AssignmentTask a) {
    return FakeAssignmentTask(
        a.number, a.internTime, a.amateurTime, a.expertTime, a.name, a.cutCode);
  }
}

class AssignmentTask {
  int number;
  String cutCode;
  String name;
  String expertTime;
  String amateurTime;
  String internTime;
  String orgCutCode;

  AssignmentTask(int number, String internTime, String amateurTime,
      String expertTime, String name, String cutCode, {this.orgCutCode}) {
    this.number = number;
    this.name = name;
    this.expertTime = expertTime;
    this.amateurTime = amateurTime;
    this.internTime = internTime;
    this.cutCode = cutCode;
  }
}

class AssignTaskPersonnel {
  int number;
  int time;
  String name;
  Personnel personnel;
  String cutCode;

  AssignTaskPersonnel(
      {this.time, this.name, this.number, this.personnel, this.cutCode});
}
