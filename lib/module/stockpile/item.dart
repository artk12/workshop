class Item {
  final String id;
  final String name;
  final String category;
  final String quantifierOne;
  final String quantify;
  final String warning;
  final String year;
  final String month;
  final String day;

  Item(
      {this.id,
      this.day,
      this.month,
      this.year,
      this.quantify,
      this.warning,
      this.name,
      this.category,
      this.quantifierOne});

  factory Item.fromJson(Map map) {
    return Item(
        category: map['category'],
        id: map['ID'],
        day: map['day'],
        name: map['name'],
        month: map['month'],
        quantifierOne: map['quantifier_one'],
        quantify: map['quantify'],
        warning: map['warning'],
        year: map['year']);
  }
}
