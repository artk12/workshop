
class Project{

  final String id;
  final String type;
  final String brand;
  final String roll;
  final String styleCode;
  final String size;
  final String description;

  Project({this.description,this.size,this.styleCode,this.type,this.roll,this.brand,this.id});

  factory Project.fromJson(Map map){
    return Project(
      id: map['ID'],
      roll: map['roll'],
      brand: map['brand'],
      type: map['type'],
      styleCode: map['style_code'],
      size: map['size'],
      description: map['description'],
    );
  }
}