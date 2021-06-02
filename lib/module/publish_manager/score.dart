import 'dart:convert';

class UserScore {
  final String id;
  final String userId;
  final List<Score> scores;

  UserScore({this.id, this.scores, this.userId});

  factory UserScore.fromJson(Map map) {
    return UserScore(
        id: map['ID'],
        userId: map['user_id'],
        scores: Score.getScores(map['scores']));
  }
}

class Score {
  final DateTime dateTime;
  final double score;

  Score({this.dateTime, this.score});

  static List<Score> getScores(String json) {
    Map map = jsonDecode(json);
    List<Score> scores = [];
    map.forEach((key, value) {
      int year = int.parse(key.substring(0, 4));
      int month = int.parse(key.substring(5));
      int day = 1;
      Score s = Score(
          dateTime: DateTime(year, month, day),
          score: double.parse(value.toString()));
      scores.add(s);
    });
    return scores;
  }
}
