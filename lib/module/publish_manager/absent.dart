class Absent {
  String id;
  String personnelId;
  DateTime date;

  Absent({this.id, this.personnelId, this.date});

  factory Absent.fromJson(Map map) {
    return Absent(
        id: map['ID'],
        personnelId: map['personnel_id'],
        date: DateTime(int.parse(map['year']), int.parse(map['month']),
            int.parse(map['day'])));
  }
}
