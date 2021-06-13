import 'dart:convert';

import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';

class Project {
  final String id;
  final String type;
  final String brand;
  final String roll;
  final String styleCode;
  final String size;
  final String description;
  final List<SizesAndStyle> sizeAndStyle;

  Project(
      {this.description,
      this.size,
      this.styleCode,
      this.type,
      this.roll,
      this.brand,
      this.id,
      this.sizeAndStyle});

  static List<SizesAndStyle> getSizeAndStyleAsList(String size){
    final json = jsonDecode(size).cast<Map<String, dynamic>>();
    List<SizesAndStyle> list = json
        .map<SizesAndStyle>((json) => SizesAndStyle.fromJson(json))
        .toList();
    return list;
  }

  factory Project.fromJson(Map map) {
    return Project(
      id: map['ID'],
      roll: map['roll'],
      brand: map['brand'],
      type: map['type'],
      styleCode: map['style_code'],
      size: map['size'],
      description: map['description'],
      sizeAndStyle: getSizeAndStyleAsList(map['size']),
    );
  }
}
