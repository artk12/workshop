class CutDetail {
  final String projectId;
  final String type;
  final String brand;
  final String roll;
  final String styleCode;
  final String projectDescription;
  final String fabricId;
  final String manufacture;
  final String calite;
  final String metric;
  final String color;
  final String pieces;
  final String fabricDescription;
  final String log;
  final String size;

  CutDetail(
      {this.type,
      this.log,
      this.brand,
      this.styleCode,
      this.roll,
      this.color,
      this.metric,
      this.fabricId,
      this.calite,
      this.pieces,
      this.manufacture,
      this.fabricDescription,
      this.projectDescription,
      this.projectId,
      this.size});

  factory CutDetail.formJson(Map map) {
    return CutDetail(
      projectId: map['project_id'],
      type: map['type'],
      size: map['size'],
      brand: map['brand'],
      roll: map['roll'],
      styleCode: map['style_code'],
      projectDescription: map['project_description'],
      fabricId: map['fabric_id'],
      manufacture: map['maufacture'],
      calite: map['calite'],
      metric: map['metric'],
      color: map['color'],
      pieces: map['pieces'],
      fabricDescription: map['fabric_description'],
    );
  }
}
