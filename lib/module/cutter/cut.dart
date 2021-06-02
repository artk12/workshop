import 'dart:convert';

import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/stockpile/fabric.dart';

class Cut {
  final String id;
  final String cutCode;
  final String year;
  final String month;
  final String day;
  final String description;
  final String pieces;
  final Fabric fabric;
  final Project project;
  final String realUsage;
  final String usage;
  final String height;
  final String totalGoods;

  Cut({
    this.project,
    this.description,
    this.id,
    this.height,
    this.year,
    this.totalGoods,
    this.cutCode,
    this.usage,
    this.realUsage,
    this.pieces,
    this.fabric,
    this.day,
    this.month,
  });

  factory Cut.fromJson(Map map) {
    return Cut(
        id: map['id'],
        height: map['height'],
        pieces: map['pieces'],
        day: map['day'],
        description: map['description'],
        month: map['month'],
        year: map['year'],
        realUsage: map['real_usage'],
        totalGoods: map['total_goods'],
        cutCode: map['cut_code'],
        usage: map['all_usage'],
        fabric: Fabric.fromJson(jsonDecode(map['fabric'])),
        project: Project.fromJson(jsonDecode(map['project'])));
  }
}
