
import 'package:flutter/foundation.dart';

class TimerControllerProviderState {
  int x;
  String id;
  bool pause;
  String s;
  double percent;
  TimerControllerProviderState({this.x, this.id,this.pause,this.s ='',this.percent = 50});
}

class TimerControllerProvider extends ChangeNotifier {
  List<TimerControllerProviderState> timerControllerProviderState ;
  String search = '';
  bool warning = false;
  TimerControllerProvider({this.timerControllerProviderState});


  void updateWarning(bool check){
    this.warning = check;
    notifyListeners();
  }

  void updateSearch(String val){
    this.search = val;
    notifyListeners();
  }

  void update(TimerControllerProviderState x) {
    int index =this
        .timerControllerProviderState
        .indexWhere((element) => element.id == x.id);
    if (index != -1) {
      this.timerControllerProviderState.removeAt(index);
      this.timerControllerProviderState.insert(index,x);
    } else {
      this.timerControllerProviderState.add(x);
    }
    notifyListeners();
  }

  void pauseAll(){
    List<TimerControllerProviderState> list = [];
    timerControllerProviderState.forEach((element) {
      TimerControllerProviderState x =  TimerControllerProviderState(id: element.id,x: element.x,pause: true,s: 'pause');
      list.add(x);
    });
    timerControllerProviderState = list;
    notifyListeners();
  }

  void playAll(){
    List<TimerControllerProviderState> list = [];
    timerControllerProviderState.forEach((element) {
      TimerControllerProviderState x =  TimerControllerProviderState(id: element.id,x: element.x,pause: false,s: 'play_again');
      list.add(x);
    });
    timerControllerProviderState = list;
    notifyListeners();
  }

  void pauseOne(String id){
    int index = timerControllerProviderState.indexWhere((element) => element.id == id);
    timerControllerProviderState[index].pause = true;
    timerControllerProviderState[index].s = '0';
    notifyListeners();
  }

  void playOne(String id){
    int index = timerControllerProviderState.indexWhere((element) => element.id == id);
    timerControllerProviderState[index].s = '1';
    timerControllerProviderState[index].pause = false;
    notifyListeners();
  }

  bool getPause(String id){
    bool pause ;
    timerControllerProviderState.forEach((element) {
      if(element.id == id){
        pause = element.pause;
      }
    });
    return pause;
  }

  String getString(String id){
    String pause = '';
    timerControllerProviderState.forEach((element) {
      if(element.id == id){
        pause = element.s;
      }
    });
    return pause;
  }
}
