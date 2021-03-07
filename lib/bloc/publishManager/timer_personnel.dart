
import 'package:bloc/bloc.dart';

class TimerPersonnelCubit extends Cubit<TimerPersonnelState>{
  TimerPersonnelCubit(TimerPersonnelState state) : super(state);

  void updatePercent(int total,int current){
    double p = (current/total)*100;
    emit(TimerPersonnelState(currentPercent: p,lastPercent: state.lastPercent));
  }
}
class TimerPersonnelState {
  double currentPercent;
  double lastPercent;
  TimerPersonnelState({this.currentPercent,this.lastPercent = 100});
}