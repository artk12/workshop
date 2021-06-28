import 'package:flutter/material.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/dialog_update_task.dart';
import 'package:workshop/request/query/delete.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

import '../default_button.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final RefreshProvider refreshProvider;
  final List<Task> tasks;

  TaskCard({this.task, this.refreshProvider, this.tasks});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return GestureDetector(
      onLongPress: ()async{
        bool check = await showDialog(
            context: context, builder: (context) {
          return DialogBg(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment
                    .center,
                children: [
                  Text("حذف فعالیت", style: Theme
                      .of(context)
                      .textTheme
                      .headline2,),
                  SizedBox(height: 15,),
                  DefaultButton(
                    title: 'حذف',
                    backgroundColor: Colors.red
                        .withOpacity(0.5),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },

                  ),
                ],
              ),
            ),
          );
        });
        if (check != null) {
          MyShowSnackBar.showSnackBar(
              context, "لطفا صبر بکنید...");
          String delete = Delete.deleteTask(task.id);
          String res =
              await MyRequest.simpleQueryRequest(
              'stockpile/runQuery.php', delete);
          if(res.trim() == "OK"){
            // taskFolders.removeWhere((element) => element.id == taskFolders[index].id);
            tasks.removeWhere((element) => element.id == task.id);
            refreshProvider.refresh();
          }
        }
      },
      onTap: () async {
        Task t = await showDialog(
            context: context,
            builder: (BuildContext context) => UpdateTask(
                  task: task,
                ));
        if (t != null) {
          int index = tasks.indexWhere((element) => element.id == t.id);
          if (index != -1) {
            tasks[index] = t;
            refreshProvider.refresh();
          }
        }
      },
      child: Container(
        // height: 100,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        constraints: BoxConstraints(maxWidth: 60),
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
        decoration: BoxDecoration(
          border: Border.all(color:Colors.black),
            borderRadius: BorderRadius.circular(5), color: Colors.white12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  task.name,
                  style: theme.textTheme.headline4,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "حرفه ای : " + task.expertTime,
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      "تازه کار : " + task.amateurTime,
                      style: theme.textTheme.headline6,
                    ),
                    Text(
                      "کار آموز : " + task.internTime,
                      style: theme.textTheme.headline6,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
