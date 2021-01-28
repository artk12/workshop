
import 'package:workshop/module/stockpile/all_items.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/warning.dart';

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
}

class CalculateStock{

  static List<AllItem> mergeFabricAndItem(List<Item> items,List<Fabric> fabrics){
    List<AllItem> allItems = [];
    for(int i = 0 ; i < items.length;i++){
      Item item = items[i];
      allItems.add(AllItem(id: item.id,category: 'item',item: item,dateTime: DateTime(int.parse(item.year),int.parse(item.month),int.parse(item.day))));
    }
    for(int i = 0 ; i < fabrics.length;i++){
      Fabric fabric = fabrics[i];
      allItems.add(AllItem(id: fabric.id,category: 'fabric',fabric: fabric,dateTime: DateTime(int.parse(fabric.year),int.parse(fabric.month),int.parse(fabric.day))));
    }
    return allItems;
  }
  static void sortAllItem(List<AllItem> allItems){
     allItems.sort((a,b) => b.dateTime.compareTo(a.dateTime));
  }

  static void sortFabric(List<Fabric> fabrics){
    fabrics.sort((a,b)=>DateTime(a.year.parseInt(),a.month.parseInt(),a.day.parseInt()).compareTo(DateTime(b.year.parseInt(),b.month.parseInt(),b.day.parseInt())));
  }

  static List<Warning> generateWarningList(List<Item> items){
    List<Warning> warnings = [];
    items.forEach((element) {
      if(element.quantifierOne.parseInt() < element.warning.parseInt()){
        warnings.add(Warning(warning: element.warning,quantify: element.quantify,name: element.name));
      }
    });
    return warnings;
  }

}