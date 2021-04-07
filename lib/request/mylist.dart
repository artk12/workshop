import 'dart:convert';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';
import 'package:workshop/module/publish_manager/personnel_assign.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/request/query/get_data.dart';
import 'package:workshop/request/request.dart';

class MyList {


  Stream<List<AssignmentLog>> getAssignmentLogs()async*{
    while(true){
      await Future.delayed(Duration(seconds: 5));
      String body = await MyRequest.getPersonnelLog();
      if(body == "not ok"){
        yield [];
      }else{
        final json = jsonDecode(body).cast<Map<String, dynamic>>();
        List<AssignmentLog> items = json.map<AssignmentLog>((json) => AssignmentLog.fromJson(json)).toList();
        yield items;
      }
    }
  }

  Future<List<Item>> getItems() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getItems);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Item> items = json.map<Item>((json) => Item.fromJson(json)).toList();
    return items;
  }

  Future<List<AssignPersonnel>> getUserTasks(String id) async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getPersonnelTask(id));
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<AssignPersonnel> items = json
        .map<AssignPersonnel>((json) => AssignPersonnel.fromJson(json))
        .toList();
    return items;
  }

  Future<List<Fabric>> getFabrics() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getFabric);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Fabric> items =
        json.map<Fabric>((json) => Fabric.fromJson(json)).toList();
    return items;
  }

  Future<List<FabricLog>> getFabricLogs() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getFabricLogs);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<FabricLog> items =
        json.map<FabricLog>((json) => FabricLog.fromJson(json)).toList();
    return items;
  }

  Future<List<ItemLog>> getItemLogs() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getItemLogs);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<ItemLog> items =
        json.map<ItemLog>((json) => ItemLog.fromJson(json)).toList();
    return items;
  }

  Future<List<Message>> getStockPileMessages() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getStockPileMessage);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Message> items =
        json.map<Message>((json) => Message.fromJson(json)).toList();
    return items;
  }

  Future<List<Message>> getPersonnelMessages() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getPersonnelMessage);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Message> items =
    json.map<Message>((json) => Message.fromJson(json)).toList();
    return items;
  }

  Future<List<Message>> getCutterMessages() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getCutterMessage);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Message> items =
        json.map<Message>((json) => Message.fromJson(json)).toList();
    return items;
  }

  Future<List<Cut>> getCutList() async {
    String body =
        await MyRequest.simpleQueryRequest('cutter/getCutList.php', '');
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Cut> items = json.map<Cut>((json) => Cut.fromJson(json)).toList();
    return items;
  }

  Future<List<Personnel>> getPersonnelList() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getAllUser);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Personnel> items =
        json.map<Personnel>((json) => Personnel.fromJson(json)).toList();
    return items;
  }

  Future<List<Task>> getTaskList() async {
    String body = await MyRequest.simpleQueryRequest(
        'stockpile/getResult.php', GetData.getAllTask);
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Task> items = json.map<Task>((json) => Task.fromJson(json)).toList();
    return items;
  }

  // static Future<List<AssignPersonnel>> getRealAssignmentTask()async{
  //   List<AssignPersonnel> items = [];
  //   // int x = 0;
  //   // while(x < 1 ){
  //     await Future.delayed(Duration(seconds: 1));
  //     String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getTodayAssignments);
  //     final  json = jsonDecode(body).cast<Map<String, dynamic>>();
  //     items = json.map<AssignPersonnel>((json) => AssignPersonnel.fromJson(json)).toList();
  //     return items;
  //     // x++;
  //   // }
  // }

  static Stream<TimerStreamer> getRealAssignmentTask(
      List<Personnel> personnel) async* {
    while (true) {
      List<PersonnelAssignHolder> personnelAssignHolders = [];
      List<StartAssign> startAssigns = [];
      List<AssignPersonnel> tasks = [];
      await Future.delayed(Duration(seconds: 3));
      String body = await MyRequest.simpleQueryRequestOneSecondDelay(
          'stockpile/getResult.php', GetData.getTodayAssignments);
      if(body == 'not ok'){
        TimerStreamer timerControllerCubit = TimerStreamer(monitorItemController: []);
      }else {
        final json = jsonDecode(body).cast<Map<String, dynamic>>();
        tasks = json
            .map<AssignPersonnel>((json) => AssignPersonnel.fromJson(json))
            .toList();
        personnel.forEach((item) {
          PersonnelAssignHolder h = new PersonnelAssignHolder();
          h.personnelSetter = item;
          List<AssignPersonnel> t =
          tasks.where((element) => element.personnelId == item.id).toList();
          // print(t.length);
          h.assignSetter = t;
          try {
            if (t.length > 0) {
              AssignPersonnel a = t.firstWhere((element) =>
              element.startDateTime != null && element.endDateTime == null);
              a.totalTask = t.length.toString();
              a.currentTask = t
                  .where((element) => element.startDateTime != null)
                  .toList()
                  .length
                  .toString();
              startAssigns.add(StartAssign(p: item, assignPersonnel: a));
            }
          } catch (e) {}
          personnelAssignHolders.add(h);
        });

        List<MonitorItemController> monitorItemList = [];

        startAssigns.forEach((element) {
          MonitorItemController item = new MonitorItemController(
              pause: element.assignPersonnel.play == '0' ? true : false,
              startAssign: element);
          monitorItemList.add(item);
        });

        TimerStreamer timerControllerCubit =
        TimerStreamer(monitorItemController: monitorItemList);

        yield timerControllerCubit;
      }

      // TimerControllerCubit t = new TimerControllerCubit(TimerControllerState(monitorItemController: monitorItemList));
      // yield t;
    }
  }
}
