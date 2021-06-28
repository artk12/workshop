import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/time_format.dart';

class PersonnelAssignmentCard extends StatelessWidget {
  final Personnel personnel;
  final List<AssignTaskPersonnel> assignPersonnelTasks;
  final String cutCode;
  PersonnelAssignmentCard({this.personnel,this.assignPersonnelTasks,this.cutCode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget taskItem(AssignTaskPersonnel a) {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            Text(
              a.cutCode,
              style: theme.textTheme.headline6.copyWith(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              a.name,
              style: theme.textTheme.headline4,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              'x ${a.number}',
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              TimeFormat.timeFormatFromDuration(Duration(seconds: a.time)),
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      );
    }

    int allTaskDuration = 0;

    assignPersonnelTasks.forEach((element) {
      allTaskDuration +=element.time;
    });

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10), color: Colors.white12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: 6, left: 5, right: 5),
            width: double.maxFinite,
            child: Text(
              personnel.level,
              style: theme.textTheme.headline6,
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6, left: 5, right: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  child: Text(
                    personnel.name,
                    style: theme.textTheme.headline3,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  children: List.generate(assignPersonnelTasks.length, (index) => taskItem(assignPersonnelTasks[index])),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text("مدت زمان فعالیت : "+TimeFormat.timeFormatFromDuration(Duration(seconds: allTaskDuration)),style: theme.textTheme.headline6,)),
          ),
        ],
      ),
    );
  }
}
