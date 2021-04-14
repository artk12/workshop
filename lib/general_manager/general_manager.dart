import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/general_manager/new_project.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/general_manager/project_card.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class GeneralManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of(context)??[];
    RefreshProvider refreshProvider = Provider.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              rightWidget: [
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewProject(projects:projects,refreshProvider: refreshProvider,)));
                }, child: Text(MyIcons.PLUS,style: MyTextStyle.iconStyle,)),
              ],
              title: 'داشبورد',
            ),
            Expanded(
              child: ListView.builder(itemCount: projects.length,itemBuilder: (BuildContext context,int index){
                return ProjectCard(project: projects[index],);
              },),
            )
          ],
        ),
      ),
    );
  }
}
