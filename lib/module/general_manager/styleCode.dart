
class StyleCode {
  String id;
  String name;
  String shortName;

  StyleCode({this.name,this.id,this.shortName});

  factory StyleCode.fromJson(Map map){
    return StyleCode(
      id:map['ID'],
      name:map['name'],
      shortName: map['short_name'],
    );
  }
}