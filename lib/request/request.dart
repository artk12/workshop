import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workshop/module/cutter/cut_detail.dart';
import 'package:workshop/module/publish_manager/score.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/query/get_data.dart';

class MyRequest {
  static String baseUrl = "https://www.rhen.ir/backend/";

  static Future getUser(String user, String pass) async {
    try {
      http.Response response = await http.post(baseUrl + "sign_in.php",
          body: {'user': user, 'pass': pass}).timeout(Duration(seconds: 5));
      print(response.body);
      if (response.statusCode != 200) {
        return 'not ok';
      } else {
        if (response.body.trim() == 'wrong') {
          return 'wrong';
        } else if (response.body.isNotEmpty) {
          try {
            Map map = jsonDecode(response.body);
            if (map['access'] == 'normal') {
              print("here1");
              return User.fromJson(map);
            } else {
              print("here2");
              return SuperUser.fromJson(map);
            }
          } catch (e) {}
        }
      }
    } catch (e) {
      return 'not ok';
    }
  }

  static Future<UserScore> getUserScore(String id) async {
    http.Response response = await http
        .post(baseUrl + "stockpile/getResult.php", body: {
      'query': GetData.getScorePersonnel(id)
    }).timeout(Duration(seconds: 5));
    if (response.body == null || response.body == '') {
      return UserScore(userId: id, scores: [], id: '0');
    }
    print(response.body);
    if (response.body.trim() == '[]') {
      return UserScore(id: '0');
    } else {
      List<dynamic> map = jsonDecode(response.body);
      UserScore userScore = UserScore.fromJson(map[0]);
      return userScore;
    }
  }

  static Future<String> getPersonnelLog() async {
    try {
      http.Response response = await http
          .post(baseUrl + "stockpile/getResult.php", body: {
        'query': GetData.getPersonnelLog
      }).timeout(Duration(seconds: 5));
      if (response.statusCode != 200) {
        return 'not ok';
      }
      print("body is :" + response.body);
      return response.body;
    } catch (e) {
      return 'not ok';
    }
  }

  static Future<String> submitTask(String id, String score, String year,
      String month, String day, String warning) async {
    http.Response response =
        await http.post(baseUrl + "personnel/submit.php", body: {
      'id': id,
      'score': score,
      'warn': warning,
      'year': year,
      'month': month,
      'day': day,
    }).timeout(Duration(seconds: 5));
    print(response.statusCode);
    if (response.statusCode != 200) {
      return "not ok";
    }
    return response.body;
  }

  static Future<String> startTask(String id, String name, String personnelName,
      String cutCode, String personnelId, String dateTime) async {
    // String dateTime = DateTime.now().toString().substring(0, 19);
    try {
      http.Response response =
          await http.post(baseUrl + "personnel/start.php", body: {
        'id': id,
        'personnelId': personnelId,
        'personnelName': personnelName,
        'cutCode': cutCode,
        'startDateTime': dateTime,
        'taskName': name,
      }).timeout(Duration(seconds: 5));
      print(response.statusCode);
      if (response.statusCode != 200) {
        return "not ok";
      }
      return response.body;
    } catch (e) {
      return "not ok";
    }
  }

  static Future<CutDetail> getCutDetail(
      String barcode, String projectCode) async {
    try{
      http.Response response = await http.post(
          baseUrl + "cutter/getCutDetail.php",
          body: {'id': projectCode, 'barcode': barcode});
      if (response.body.trim() != "null") {
        CutDetail cutDetail = CutDetail.formJson(jsonDecode(response.body));
        return cutDetail;
      }
    }catch(e){
      return null;
    }
    return null;
  }

  Future<String> sayHello() async {
    http.Response response = await http
        .post(baseUrl + 'stockpile/check.php', body: {'hello': 'hello its me'});
    return response.body;
  }

  static Future<String> insertAssignRequest(String json) async {
    DateTime now = DateTime.now();
    if (now.hour > 19) {
      now.add(Duration(days: 1));
    }
    print(json);
    http.Response response =
        await http.post(baseUrl + 'publish_manager/insertAssign.php', body: {
      'assignJson': json,
      'year': now.year.toString(),
      'month': now.month.toString(),
      'day': now.day.toString()
    }).onError((error, stackTrace) => null);
    if (response == null) {
      return "not ok";
    }
    return response.body;
  }

  static Future<String> pauseAllRequest(String json) async {
    http.Response response = await http.post(
        baseUrl + 'publish_manager/pauseAll.php',
        body: {'pausePlay': json}).onError((error, stackTrace) => null);
    if (response == null) {
      return "not ok";
    }
    return response.body;
  }

  static Future<String> simpleQueryRequestWithTimeOut(
      String url, String query) async {
    try {
      http.Response response = await http
          .post(baseUrl + url, body: {'query': query})
          .onError((error, stackTrace) => null)
          .timeout(Duration(seconds: 3));
      if (response == null) {
        return "not ok";
      }
      return response.body;
    } catch (e) {
      return '';
    }
  }

  static Future<String> simpleQueryRequest(String url, String query) async {
    http.Response response = await http.post(baseUrl + url,
        body: {'query': query}).onError((error, stackTrace) => null);
    if (response == null) {
      return "not ok";
    }
    return response.body;
  }

  static Future<String> simpleQueryRequestOneSecondDelay(
      String url, String query) async {
    try {
      http.Response response = await http.post(baseUrl + url,
          body: {'query': query}).onError((error, stackTrace) => null);
      if (response == null) {
        return "not ok";
      }
      return response.body;
    } catch (e) {
      return 'not ok';
    }
  }

  static Future<String> getUserTasks(String id) async {
    String query = GetData.getPersonnelTask(id);
    http.Response response = await http.post(
        baseUrl + 'stockpile/getResult.php',
        body: {'query': query}).onError((error, stackTrace) => null);
    if (response == null) {
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

  static Future<String> insertCutRequest(String insert, String update,String pieces) async {
    try{
      http.Response response = await http
          .post(baseUrl + 'cutter/insertCut.php', body: {'query1': insert, 'query2': update,'pieces':pieces});
      return response.body;
    }catch(e){
      return null;
    }
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

  static Future<SuperUser> getSuperUserDetail(String user, String pass) async {
    http.Response response = await http.post(
        baseUrl + 'stockpile/getResult.php',
        body: {'query': GetData.getSuperUser(user, pass)});
    List<dynamic> map = jsonDecode(response.body);
    SuperUser currentUser = SuperUser.fromJson(map[0]);
    return currentUser;
  }

  static Future<User> getNormalUserDetail(String user, String pass) async {
    http.Response response = await http.post(
        baseUrl + 'stockpile/getResult.php',
        body: {'query': GetData.getNormalUser(user, pass)});
    List<dynamic> map = jsonDecode(response.body);
    User currentUser = User.fromJson(map[0]);
    return currentUser;
  }

  static Future<String> addNewFabric(String manufacture, String calite,
      String metric, String color, String pieces, String description) async {
    Map<String, dynamic> params = {
      'manufacture': manufacture,
      'calite': calite,
      'metric': metric,
      'color': color,
      'pieces': pieces,
      'description': description,
    };
    http.Response response = await http
        .post(baseUrl + 'stockpile/insert_new_fabric.php', body: params);
    return response.body;
  }
}
