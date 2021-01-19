
import 'dart:convert';

import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/request/query/get_data.dart';
import 'package:workshop/request/request.dart';

class MyList {

  static Future<List<Item>> getItems() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getItems);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Item> items = json.map<Item>((json) => Item.fromJson(json)).toList();
    return items;
  }

  static Future<List<Fabric>> getFabrics() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getFabric);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Fabric> items = json.map<Fabric>((json) => Fabric.fromJson(json)).toList();
    return items;
  }

}