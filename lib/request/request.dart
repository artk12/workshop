// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class MyRequest {
  static String baseUrl = "http://www.rhen.ir/backend/";
  Future<String> sayHello() async {
    http.Response response = await http
        .post(baseUrl + 'stockpile/check.php', body: {'hello': 'hello its me'});
    return response.body;
  }

  static Future<String> simpleQueryRequest(String url, String query) async {
    http.Response response =
        await http.post(baseUrl + url, body: {'query': query});
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
