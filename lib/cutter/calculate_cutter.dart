import 'dart:convert';

import 'package:workshop/cutter/cutter_detail_page.dart';
import 'package:workshop/module/cutter/cut.dart';

import '../cutter/cutter_page.dart';

class CalculateCutter {
  static bool checkPiecesField(
      List<MyTextEditingController> myTextEditingControllers) {
    for (int i = 0; i < myTextEditingControllers.length; i++) {
      MyTextEditingController myTextEditingController =
          myTextEditingControllers[i];
      if (myTextEditingController.quantify.text.isEmpty ||
          myTextEditingController.surplus.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  static int getCutCount(List<MyTextEditingController> textEditingControllers,List<String> styleCode){
    int count = 0;
    for(int i = 0 ; i < textEditingControllers.length ; i++){
      for(int j = 0 ; j < styleCode.length ; i++){
        count++;
      }
    }
    return count;
  }

  static List<CutCode> getCutCodeList(
      List<MyTextEditingController> textEditingControllers,List<String> styleCode,String projectId,String currentRoll) {
    List<CutCode> cutCodes = [];
    for (int i = 0; i < textEditingControllers.length; i++) {
      for(int j = 0 ; j < styleCode.length;j++){
        String cutCode = '$projectId-$currentRoll-${i + 1}-${styleCode[j]}';
        cutCodes.add(CutCode(cutCode: cutCode));
      }
    }
    return cutCodes;
  }

  static String getCutCodeListJson(
      List<MyTextEditingController> textEditingControllers,List<String> styleCode,String projectId,String currentRoll) {
    List<Map> cutCodes = [];
    for (int i = 0; i < textEditingControllers.length; i++) {
      for(int j = 0 ; j < styleCode.length;j++){
        Map<String,String> map = {
          'cutCode':'$projectId-$currentRoll-${i + 1}-${styleCode[j]}'
        };
        cutCodes.add(map);
      }
    }
    return jsonEncode(cutCodes);
  }

  static String getPiecesJson(
      List<MyTextEditingController> textEditingControllers,List<String> styleCode,String projectId,String currentRoll) {
    List<Map> maps = [];

    for (int i = 0; i < textEditingControllers.length; i++) {
      for(int j = 0 ; j < styleCode.length;j++){
        Map<String, String> map = {};
        MyTextEditingController myTextEditingController =
        textEditingControllers[i];
        map["layer"] = myTextEditingController.quantify.text;
        map["surplus"] = myTextEditingController.surplus.text;
        map['cutCode'] = '$projectId-$currentRoll-${i + 1}-${styleCode[j]}';
        maps.add(map);
      }
    }
    return jsonEncode(maps);
  }

  static List<Pieces> getPiecesFromJson(String body) {
    final json = jsonDecode(body).cast<Map<String, dynamic>>();
    List<Pieces> items =
        json.map<Pieces>((json) => Pieces.fromJson(json)).toList();
    return items;
  }
}
