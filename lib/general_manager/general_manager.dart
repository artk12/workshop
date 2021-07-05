import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/general_manager/general_drawer.dart';
import 'package:workshop/general_manager/new_project.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/general_manager/styleCode.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/general_manager/project_card.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class GeneralManager extends StatelessWidget {
  final SuperUser user;
  GeneralManager({this.user});
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of(context);
    List<StyleCode> styleCodes = Provider.of(context);
    RefreshProvider refreshProvider = Provider.of(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


    return projects == null || styleCodes == null? LoadingPage():Scaffold(
      key: _scaffoldKey,
      drawer: GeneralDrawer(user: user,scaffoldKey: _scaffoldKey,),
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              leftWidget: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewProject(
                            projects: projects,
                            styleCodes:styleCodes,
                            refreshProvider: refreshProvider,
                          )));
                    },
                    child: Text(
                      MyIcons.PLUS,
                      style: MyTextStyle.iconStyle,
                    )),
              ],
              rightWidget: [
                MyIconButton(
                  icon: MyIcons.DRAWER_ICON,
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ],
              title: 'داشبورد',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProjectCard(
                    project: projects[index],
                    projects: projects,
                    refreshProvider:refreshProvider,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
