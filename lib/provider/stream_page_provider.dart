import 'package:flutter/cupertino.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';

class StreamPageProvider extends ChangeNotifier {
  TimerStreamer timerStreamer;

  StreamPageProvider() {
    timerStreamer = TimerStreamer(monitorItemController: []);
  }

  set timerStreamerSetter(TimerStreamer timerStreamer) {
    if (timerStreamer != null) {
      // print(timerStreamer.monitorItemController.length);
      if (this.timerStreamer.monitorItemController.length == 0) {
        // print(timerStreamer.monitorItemController[0].startAssign.assignPersonnel.play);
        this.timerStreamer = timerStreamer;
        notifyListeners();
        print("4");
      } else if (!isEqual(timerStreamer)) {
        this.timerStreamer = timerStreamer;
        print("3");
        notifyListeners();
      }
    }
  }

  bool isEqual(TimerStreamer timerStreamer) {
    bool check = true;
    if (timerStreamer.monitorItemController.length >
        this.timerStreamer.monitorItemController.length) {
      print("3-1");
      check = false;
    } else {
      for (int i = 0;
          i < this.timerStreamer.monitorItemController.length;
          i++) {
        AssignPersonnel a = this
            .timerStreamer
            .monitorItemController[i]
            .startAssign
            .assignPersonnel;
        AssignPersonnel b =
            timerStreamer.monitorItemController[i].startAssign.assignPersonnel;
        if (a.playDateTime != b.playDateTime || b.play != a.play) {
          print("3-2");
          check = false;
          break;
        }
      }
    }
    return check;
  }
}
