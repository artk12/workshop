import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/module/general_manager/project.dart';

import '../background_widget.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({this.project});

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
      decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(10)),
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
          SizedBox(height: 25,),
          Text(
            project.description,
            style: theme.textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
