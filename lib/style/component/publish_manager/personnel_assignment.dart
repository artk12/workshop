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
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            a.cutCode.indexOf(',') != -1?Container():Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    a.name,
                    style: theme.textTheme.headline4,
                  ),
                ),
                Text(
                  a.cutCode,
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.headline6.copyWith(fontSize: 14),
                ),
              ],
            ),
            a.cutCode.indexOf(',') == -1?Container():Text(
              a.name,
              style: theme.textTheme.headline4,
            ),
            SizedBox(
              height: 5,
            ),
            // Expanded(
            //   child: Container(),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'x ${a.number}',
                  style: theme.textTheme.headline5,
                ),
                Text(
                  TimeFormat.timeFormatFromDuration(Duration(seconds: a.time)),
                  style: theme.textTheme.headline6,
                ),
              ],
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
