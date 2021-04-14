import 'package:flutter/material.dart';
import 'package:workshop/module/general_manager/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  ProjectCard({this.project});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                project.id+" # ",
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
                project.size,
                style: theme.textTheme.headline4.copyWith(height: 2),
              ),
                  )),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            project.description,
            style: theme.textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
