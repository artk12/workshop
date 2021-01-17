
import 'dart:convert';

import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/request/query/get_data.dart';
import 'package:workshop/request/request.dart';

class MyList {

  static Future<List<ItemNameAvailable>> getAvailableItems() async{
    String body = await MyRequest.simpleQueryRequest('stockpile/getResult.php',GetData.getAvailableItem);
    final  json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<ItemNameAvailable> items = json.map<ItemNameAvailable>((json) => ItemNameAvailable.fromJson(json)).toList();
    return items;
  }

}