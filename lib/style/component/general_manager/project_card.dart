import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

import '../background_widget.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final List<Project> projects;
  final RefreshProvider refreshProvider;

  ProjectCard({this.project, this.projects, this.refreshProvider});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final json = jsonDecode(project.size).cast<Map<String, dynamic>>();

    List<SizesAndStyle> list = json
        .map<SizesAndStyle>((json) => SizesAndStyle.fromJson(json))
        .toList();
    List<Widget> widgets = [];
    list.forEach((element) {
      widgets.add(Container(
        margin: EdgeInsets.all(7),
        child: BackgroundWidget(
          height: 80,
          width: 80,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(element.size),
                SizedBox(
                  height: 5,
                ),
                Text(element.style),
              ],
            ),
          ),
        ),
      ));
    });

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                project.id + " # ",
                style: theme.textTheme.headline2,
              ),
            ],
          ),
          Text(
            "برند : " + project.brand,
            style: theme.textTheme.headline2,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "مدل : " + project.type,
                        style: theme.textTheme.headline4,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "طاقه : " + project.roll,
                        style: theme.textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    project.styleCode,
                    style: theme.textTheme.headline4.copyWith(height: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Wrap(
            children: widgets,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            project.description,
            style: theme.textTheme.headline4,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(project.rollComplete +
                    " از " +
                    project.roll +
                    "تکمیل شده است."),
              ),
              int.parse(project.rollComplete) < int.parse(project.roll)
                  ? TextButton(
                      onPressed: () async {
                        String check = await showDialog(context: context, builder: (context)=>DialogBg(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 25),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                             children: [
                               Text("اتمام پروژه",style: theme.textTheme.headline3,),
                               SizedBox(height: 20,),
                               Text("آیا میخواهید اتمام پروژه را ثبت کنید؟",style: theme.textTheme.bodyText2,),
                               SizedBox(height: 30,),
                               SaveAndCancelButton(
                                 saveButton: (){Navigator.of(context).pop("OK");},
                                 cancelButton: (){Navigator.of(context).pop("NO");},
                               )
                             ],
                            ),
                          ),
                        ));
                        if(check!=null){
                          if(check == "OK"){
                            MyShowSnackBar.showSnackBar(context, 'لطفا صبر کنید.');
                            String res = await MyRequest.simpleQueryRequest(
                                'stockpile/runQuery.php',
                                Update.updateRoll(
                                    project.id, project.rollComplete));
                            if (res.trim() == 'OK') {
                              MyShowSnackBar.hideSnackBar(context);
                              MyShowSnackBar.showSnackBar(
                                  context, 'درخواست شما با موقیت ثبت شد.');
                              projects
                                  .firstWhere((element) => element.id == project.id)
                                  .roll = project.rollComplete;
                              refreshProvider.refresh();
                            } else {
                              MyShowSnackBar.showSnackBar(context,
                                  'خطا در برقراری ارتباط لطفا مجددا تلاش کنید.');
                            }
                          }
                        }
                      },
                      child: Text(
                        "اتمام پروژه",
                        style: theme.textTheme.headline5
                            .copyWith(color: Color(0xFF98180E)),
                      ),
                    )
                  : CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green,
                      child: Text(
                        MyIcons.CHECK,
                        style:
                            MyTextStyle.iconStyle.copyWith(color: Colors.white),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
