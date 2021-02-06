import 'package:flutter/material.dart';
import 'package:workshop/general_manager/new_project.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class GeneralManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              rightWidget: [
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewProject()));
                }, child: Text(MyIcons.PLUS,style: MyTextStyle.iconStyle,)),
              ],
              title: 'داشبورد',
            )
          ],
        ),
      ),
    );
  }
}
