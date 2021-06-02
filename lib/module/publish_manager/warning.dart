import 'dart:convert';

class UserWarning {
  final String id;
  final String userId;
  final List<Warning> warnings;

  UserWarning({this.id, this.warnings, this.userId});

  factory UserWarning.fromJson(Map map) {
    return UserWarning(
        id: map['ID'],
        userId: map['user_id'],
        warnings: Warning.getWarning(map['warnings']));
  }
}

class Warning {
  final DateTime dateTime;
  final int warning;

  Warning({this.dateTime, this.warning});

  static List<Warning> getWarning(String json) {
    Map map = jsonDecode(json);
    List<Warning> warnings = [];
    map.forEach((key, value) {
      int year = int.parse(key.substring(0, 4));
      int month = int.parse(key.substring(5));
      int day = 1;
      Warning w = Warning(
          dateTime: DateTime(year, month, day),
          warning: int.parse(value.toString()));
      warnings.add(w);
    });
    return warnings;
  }
}
