import 'package:flutter/material.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/dialog_update_task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final RefreshProvider refreshProvider;
  final List<Task> tasks;
  TaskCard({this.task,this.refreshProvider,this.tasks});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: ()async{
        Task t = await showDialog(context: context, builder: (BuildContext context)=>UpdateTask(task: task,));
        if(t != null){
          int index = tasks.indexWhere((element) => element.id == t.id);
          if(index != -1){
            tasks[index] = t;
            refreshProvider.refresh();
          }
        }
      },
      child: Container(
        // height: 100,
        constraints: BoxConstraints(maxWidth: 60),
        // margin: EdgeInsets.all(10),
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
              mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
