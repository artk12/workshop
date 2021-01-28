class User{
  String id;
  String name;
  String side;
  String profile;
  String user;
  String pass;
  User({this.id,this.name,this.profile,this.side,this.user,this.pass});

  factory User.fromJson(Map map){
    return User(id: map['id'],name: map['name'],profile: map['profile_address'],side: map['side'],pass: map['pass'],user: map['user']);
  }
}