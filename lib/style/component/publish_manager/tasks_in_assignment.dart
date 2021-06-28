
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/provider/new_task_page_provider.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';

class TaskInAssignment extends StatelessWidget {
  final TaskFolder taskFolder;
  final List<TaskChecksAssign> tasks;
  final ThemeData theme;
  final NewTaskPageProvider provider;
  TaskInAssignment({this.taskFolder,this.tasks,this.theme,this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black87),
      ),
      child: Column(
        children: [
          MyAppbar(title: taskFolder.name,),
          Divider(height: 1,color: Colors.black26,),
          tasks.length == 0 ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child:Text("فعالیتی برای این دسته یافت نشد.",style: theme.textTheme.headline6.copyWith(height: 2),)),
          ) : Wrap(
            children: List.generate(tasks.length, (i) => CheckboxListTile(
              title: Text(tasks[i].task.name,
                  style: theme.textTheme.headline5),
              value: tasks[i].check,
              onChanged: (check) {
                provider.updateTaskCheck(check, tasks[i].task.id);
              },
              controlAffinity: ListTileControlAffinity.leading,
            )),
          )

        ],
      ),
    );
  }
}
