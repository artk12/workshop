import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/taskFolderCard.dart';

import 'dialog_add_new_folder_task.dart';

class TasksPage extends StatelessWidget {
  final List<Task> tasks;
  final List<TaskFolder> taskFolders;

  TasksPage({this.tasks, this.taskFolders});

  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;

    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Row(
            children: [
              DefaultButton(
                title: 'پوشه جدید',
                onPressed: () async {
                  TaskFolder t = await showDialog(
                    context: context,
                    builder: (context) => AddNewFolderTask(),
                    barrierColor: Colors.black54,
                  );
                  if (t != null) {
                    taskFolders.add(t);
                    refreshProvider.refresh();
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              // padding: EdgeInsets.all(5),
              children: List.generate(
                  taskFolders.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChangeNotifierProvider.value(
                          value: refreshProvider,
                          child: TaskFolderCard(
                            taskFolder: taskFolders[index],
                            tasksFolder: taskFolders,
                            tasks: tasks,
                          ),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
