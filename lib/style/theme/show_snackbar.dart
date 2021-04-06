
import 'package:flutter/material.dart';

class MyShowSnackBar{

  static showSnackBar(BuildContext context,String content){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),)));
  }
  static longShowSnackBar(BuildContext context,String content){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration:Duration(days: 1),content: Text(content,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 14),)));
  }
  static hideSnackBar(BuildContext context){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}