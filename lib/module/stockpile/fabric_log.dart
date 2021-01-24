
class FabricLog{
  String id;
  String fabricId;
  String log;
  String person;
  String description;
  String year;
  String month;
  String day;

  FabricLog({this.log,this.id,this.person,this.description,this.month,this.year,this.day,this.fabricId});

  factory FabricLog.fromJson(Map map){
    return FabricLog(
      person: map['person'],
      log: map['log'],
      id: map['id'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      description: map['description'],
      fabricId: map['fabric_id']
    );
  }
}