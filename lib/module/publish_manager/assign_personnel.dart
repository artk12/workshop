import 'package:workshop/module/publish_manager/personnel.dart';

class AssignPersonnel {
  String id;
  String number;
  String time;
  String name;
  String personnelId;
  String cutCode;
  String startDateTime;
  // String pauseDateTime;
  String play;
  String endDateTime;
  String assignDateTime;
  String score;
  String remainingTime;
  AssignPersonnel({
    this.id,
    this.time,
    this.name,
    this.number,
    this.personnelId,
    this.cutCode,
    this.assignDateTime,
    this.endDateTime,
    // this.pauseDateTime,
    this.play,
    this.startDateTime,
    this.score,
    this.remainingTime,
  });

  factory AssignPersonnel.fromJson(Map map) {
    return AssignPersonnel(
      id: map['ID'],
      personnelId: map['personnel_id'],
      cutCode: map['cut_code'],
      time: map['time'],
      number: map['number'],
      name: map['name'],
      assignDateTime: map['assignment_date_time'],
      endDateTime: map['submit_date_time'],
      startDateTime: map['start_date_time'],
      // pauseDateTime: map['pause_date_time'],
      play: map['play'],
      score: map['score'],
      remainingTime: map['remaining_time'],
    );
  }
}

class StartAssign {
  Personnel p;
  AssignPersonnel assignPersonnel;

  StartAssign({this.p, this.assignPersonnel});
}
