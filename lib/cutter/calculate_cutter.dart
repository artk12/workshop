import 'dart:convert';

import '../cutter/cutter_page.dart';

class CalculateCutter{

  static bool checkPiecesField(List<MyTextEditingController> myTextEditingControllers){
    for(int i = 0 ; i < myTextEditingControllers.length ; i++){
      MyTextEditingController myTextEditingController = myTextEditingControllers[i];
      if(myTextEditingController.quantify.text.isEmpty || myTextEditingController.surplus.text.isEmpty){
        return false;
      }
    }
    return true;
  }

  static String getPiecesJson(List<MyTextEditingController> textEditingControllers){

    List<Map> maps = [];

    for(int i = 0 ; i < textEditingControllers.length ; i++){
      Map<String,String> map = {};
      MyTextEditingController myTextEditingController = textEditingControllers[i];
      map["layer"] =  myTextEditingController.quantify.text;
      map["surplus"] =  myTextEditingController.surplus.text;
      maps.add(map);
    }
    return jsonEncode(maps);
  }
}