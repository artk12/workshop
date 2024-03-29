class Fabric {
  String id;
  String manufacture;
  String calite;
  String metric;
  String color;
  String pieces;
  String description;
  String year;
  String month;
  String day;
  String log;
  String barCode;

  Fabric(
      {this.id,
      this.year,
      this.description,
      this.month,
      this.day,
      this.color,
      this.pieces,
      this.metric,
      this.calite,
      this.manufacture,
      this.log,
      this.barCode});

  factory Fabric.fromJson(Map map) {
    return Fabric(
        id: map['ID'],
        year: map['year'],
        month: map['month'],
        day: map['day'],
        color: map['color'],
        calite: map['calite'],
        description: map['description'],
        manufacture: map['manufacture'],
        metric: map['metric'],
        pieces: map['pieces'],
        barCode: map['barcode'],
        log: map['log']);
  }
}
