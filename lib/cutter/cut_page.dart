import 'package:flutter/material.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/cutter/cut_card.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';

class CutPage extends StatelessWidget {
  final Project project;
  final List<Cut> cutList;
  CutPage({this.project,this.cutList});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<Cut> projectCutList = [];
    int totalGoods = 0;
    int totalRealUsage = 0;
    double averageRealUsage = 0;
    try{
      projectCutList = cutList.where((element) => element.project.id == project.id).toList();
      projectCutList.forEach((element) {
        totalRealUsage += int.parse(element.realUsage);
        totalGoods += int.parse(element.totalGoods);
      });
      averageRealUsage = totalRealUsage / projectCutList.length;

    }catch(e){}
    String totalUse = 'ندارد';
    try{
      totalUse = projectCutList.first.usage;
    }catch(e){}


    return Scaffold(
      bottomSheet: Container(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("مصرف کل : "+totalUse,style: theme.textTheme.headline4,),
                Text("تعداد برشها : "+projectCutList.length.toString(),style: theme.textTheme.headline4,)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("جمع کل کار : "+totalGoods.toString(),style: theme.textTheme.headline4,),
                Text("مصرف واقعی کل : "+averageRealUsage.toStringAsFixed(2),style: theme.textTheme.headline4,),
              ],
            ),

          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 81),
          child: Column(
            children: [
              MyAppbar(
                title: 'برش های پروژه ' + project.id,
                leftWidget: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: MyIconButton(
                      icon: MyIcons.ARROW_UP,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: projectCutList.length,
                  itemBuilder: (context, index) => CutCard(
                    width: double.maxFinite,
                    height: 110,
                    cut: projectCutList[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
