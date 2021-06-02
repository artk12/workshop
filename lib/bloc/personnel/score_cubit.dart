import 'package:bloc/bloc.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit(ScoreState state) : super(state);

  void updateScore(double currentScore) {
    double p = state.score += currentScore;
    emit(ScoreState(score: p));
  }
}

class ScoreState {
  double score;

  ScoreState({this.score});
}
