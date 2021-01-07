
class ItemNameAvailable{
  final String id;
  final String name;
  ItemNameAvailable({this.id = '',this.name=''});

  factory ItemNameAvailable.fromJson(Map<String,dynamic> map){
    return ItemNameAvailable(id: map['ID'],name: map['name'] as String);
  }

}