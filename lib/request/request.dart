// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:workshop/request/query/get_data.dart';

class MyRequest{

  Future<String>? sayHello()async{
    http.Response response = await http.post('http://www.rhen.ir/backend/stockpile/check.php',body: {'hello':'hello its me'});
    return response.body;
  }

  Future<String> getAvailableItemsRequest()async{
    http.Response response = await http.post('http://www.rhen.ir/backend/stockpile/getResult.php',body: {'query':GetData.getAvailableItem});
    return response.body;
  }
}