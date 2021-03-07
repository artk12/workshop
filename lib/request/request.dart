import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workshop/module/cutter/cut_detail.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/query/get_data.dart';

class MyRequest {

  static String baseUrl = "https://www.rhen.ir/backend/";

  static Future<CutDetail> getCutDetail(String calite,String projectCode)async{
    http.Response response = await http.post(baseUrl+"cutter/getCutDetail.php",body:{'id':projectCode,'calite':calite});
    if(response.body.trim() != "null"){
      CutDetail cutDetail = CutDetail.formJson(jsonDecode(response.body));
      return cutDetail;
    }
    return null;
  }

  Future<String> sayHello() async {
    http.Response response = await http
        .post(baseUrl + 'stockpile/check.php', body: {'hello': 'hello its me'});
    return response.body;
  }

  static Future<String> insertAssignRequest(String json) async {
    http.Response response = await http.post(baseUrl + 'publish_manager/insertAssign.php', body: {'assignJson': json}).onError((error, stackTrace) => null);
    if(response == null){
      return "not ok";
    }
    return response.body;
  }

  static Future<String> simpleQueryRequest(String url, String query) async {
    http.Response response = await http.post(baseUrl + url, body: {'query': query}).onError((error, stackTrace) => null);
    if(response == null){
      return "not ok";
    }
    return response.body;
  }

  static Future<String> simple2QueryRequest(
      String url, String query1, String query2) async {
    http.Response response = await http
        .post(baseUrl + url, body: {'query1': query1, 'query2': query2});
    return response.body;
  }

  static Future<String> addNewItem(String newItemName, String newItemCategory,
      String firstQuantifier, String quantify, String warning) async {
    Map<String, dynamic> params = {
      'newName': newItemName,
      'newNameCategory': newItemCategory,
      'firstQuantifier': firstQuantifier,
      'quantify': quantify,
      'warning': warning
    };
    http.Response response = await http
        .post(baseUrl + 'stockpile/insert_new_item.php', body: params);
    return response.body;
  }

  static Future<User> getUserDetail(String user,String pass)async{
      http.Response response = await http
          .post(baseUrl + 'stockpile/getResult.php', body: {'query': GetData.getUser(user, pass)});
    List<dynamic> map = jsonDecode(response.body);
    User currentUser = User.fromJson(map[0]);
    return currentUser;
  }

  static Future<String> addNewFabric(String manufacture, String calite,
      String metric, String color, String pieces,String description) async {
    Map<String, dynamic> params = {
      'manufacture': manufacture,
      'calite': calite,
      'metric': metric,
      'color': color,
      'pieces': pieces,
      'description':description,
    };
    http.Response response = await http
        .post(baseUrl + 'stockpile/insert_new_fabric.php', body: params);
    return response.body;
  }
}
