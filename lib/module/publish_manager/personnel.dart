class Personnel {
  String id;
  String name;
  String nationalCode;
  String fatherName;
  String birthDay;
  String hireDate;
  String position;
  String level;

  Personnel(
      {this.id,
      this.name,
      this.birthDay,
      this.fatherName,
      this.hireDate,
      this.level,
      this.nationalCode,
      this.position});

  factory Personnel.fromJson(Map map){
    return Personnel(
      id:map['ID'],
      name: map['name'],
      birthDay: map['birth_date'],
      fatherName: map['father_name'],
      hireDate: map['hire_date'],
      nationalCode: map['national_code'],
      level: map['level'],
      position: map['position'],
    );
  }
}
