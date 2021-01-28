
import 'dart:convert';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/request/query/get_data.dart';
import 'package:workshop/request/request.dart';

class MyList {

  Future<List<Item>> getItems() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getItems);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Item> items = json.map<Item>((json) => Item.fromJson(json)).toList();
    return items;
  }

  Future<List<Fabric>> getFabrics() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getFabric);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Fabric> items = json.map<Fabric>((json) => Fabric.fromJson(json)).toList();
    return items;
  }

  Future<List<FabricLog>> getFabricLogs() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getFabricLogs);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<FabricLog> items = json.map<FabricLog>((json) => FabricLog.fromJson(json)).toList();
    return items;
  }

  Future<List<ItemLog>> getItemLogs() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getItemLogs);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<ItemLog> items = json.map<ItemLog>((json) => ItemLog.fromJson(json)).toList();
    return items;
  }

  Future<List<Message>> getStockPileMessages() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getStockPileMessage);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Message> items = json.map<Message>((json) => Message.fromJson(json)).toList();
    return items;
  }

}