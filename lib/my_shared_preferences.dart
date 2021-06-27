
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{

  void save(String user,String pass)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user);
    prefs.setString("pass", pass);
  }

  Future<UserPass> getUserAndPass()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserPass(user: prefs.getString("user")??"not found",pass: prefs.getString("pass")??"not fount");
  }

  void clean()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

}

class UserPass{
  String user;
  String pass;
  UserPass({this.pass,this.user});
}