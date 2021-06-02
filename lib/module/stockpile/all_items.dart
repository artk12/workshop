import 'fabric.dart';
import 'item.dart';

class AllItem {
  Item item;
  Fabric fabric;
  DateTime dateTime;
  String id;
  String category;

  AllItem({this.id, this.item, this.dateTime, this.category, this.fabric});
}
