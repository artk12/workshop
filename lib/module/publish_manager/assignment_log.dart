class AssignmentLog {
  String id;
  String personnelId;
  String personnelName;
  String taskName;
  String log;
  String cutCode;

  AssignmentLog(
      {this.taskName,
      this.personnelName,
      this.personnelId,
      this.id,
      this.log,
      this.cutCode});

  factory AssignmentLog.fromJson(Map map) {
    return AssignmentLog(
      id: map['ID'],
      personnelId: map['personnel_id'],
      personnelName: map['personnel_name'],
      taskName: map['task_name'],
      log: map['log'],
      cutCode: map['cut_code'],
    );
  }
}
