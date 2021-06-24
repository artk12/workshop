import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/task_folder_page.dart';

class TaskFolderCard extends StatelessWidget {
  final TaskFolder taskFolder;
  final List<TaskFolder> tasksFolder;
  final List<Task> tasks;

  TaskFolderCard({this.taskFolder, this.tasksFolder, this.tasks});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    RefreshProvider refreshProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        List<Task> list = [];
        tasks.forEach((element) {
          if (element.groupId == taskFolder.id) {
            list.add(element);
          }
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext c) => ChangeNotifierProvider.value(
              value: refreshProvider,
              child: TaskFolderPage(
                taskFolder: taskFolder,
                tasks: tasks,
              ),
            ),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 60),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 9),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              taskFolder.name,
              style: theme.textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
