import 'package:flutter/material.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/dialog_add_new_task.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/taskCard.dart';

class TasksPage extends StatelessWidget {
  final RefreshProvider refreshProvider;
  final List<Task> tasks;

  TasksPage({this.tasks,this.refreshProvider});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 2;

    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Row(
            children: [
              DefaultButton(
                title: 'فعالیت جدید',
                onPressed: () async {
                  Task t = await showDialog(
                    context: context,
                    builder: (context) => AddNewTask(),
                    barrierColor: Colors.black54,
                  );
                  if(t != null){
                    tasks.add(t);
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
              children: List.generate(tasks.length, (index) => TaskCard(task:tasks[index],refreshProvider: refreshProvider,tasks: tasks,)),
            ),
          )
        ],
      ),
    );
  }
}
