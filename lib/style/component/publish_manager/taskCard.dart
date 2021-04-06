import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  TaskCard({this.task});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 50,
      constraints: BoxConstraints(maxWidth: 60),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text("حرفه ای : ",style: theme.textTheme.headline6,),
                  Text(task.expertTime,style: theme.textTheme.headline4,),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text("تازه کار : ",style: theme.textTheme.headline6,),
                  Text(task.amateurTime,style: theme.textTheme.headline4,),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text("کارآموز : ",style: theme.textTheme.headline6,),
                  Text(task.internTime,style: theme.textTheme.headline4,),
                ],
              ),
            ],
          ),
          Text(task.name,style: theme.textTheme.headline4,),
        ],
      ),
    );
  }
}