import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/general_manager/new_project.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/general_manager/styleCode.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/general_manager/project_card.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class GeneralManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Project> projects = Provider.of(context);
    List<StyleCode> styleCodes = Provider.of(context);
    RefreshProvider refreshProvider = Provider.of(context);
    ThemeData theme = Theme.of(context);

    return projects == null || styleCodes == null? LoadingPage():Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              leftWidget: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(onPressed: (){
                    MySharedPreferences().clean();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                    );
                  }, child: Text("خروج از حساب",style: theme.textTheme.headline6.copyWith(fontSize: 11),)),
                )
              ],
              rightWidget: [
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
              title: 'داشبورد',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProjectCard(
                    project: projects[index],
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
