class SuperUser {
  String id;
  String name;
  String side;
  String profile;
  String user;
  String pass;
  SuperUser(
      {this.id, this.name, this.profile, this.side, this.user, this.pass});

  factory SuperUser.fromJson(Map map) {
    return SuperUser(
        id: map['id'],
        name: map['name'],
        profile: map['profile_address'],
        side: map['side'],
        pass: map['pass'],
        user: map['user']);
  }
}

class User {
  String id;
  String name;
  String nationalCode;
  String pass;
  String fatherName;
  String birthDay;
  String hireDay;
  String position;
  String level;
  String profile;

  User(
      {this.id,
      this.name,
      this.level,
      this.birthDay,
      this.fatherName,
      this.hireDay,
      this.nationalCode,
      this.position,
      this.profile,
      this.pass});

  factory User.fromJson(Map map) {
    return User(
      id: map['ID'],
      name: map['name'],
      nationalCode: map['national_code'],
      birthDay: map['birth_date'],
      fatherName: map['father_name'],
      level: map['level'],
      position: map['position'],
      profile: map['profile'],
      pass: map['pass'],
      hireDay: map['hire_date'],
    );
  }
}
