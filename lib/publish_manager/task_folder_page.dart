import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/dialog_add_new_task.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/component/publish_manager/taskCard.dart';
import 'package:workshop/style/theme/my_icons.dart';

class TaskFolderPage extends StatelessWidget {
  final List<Task> tasks;
  final TaskFolder taskFolder;
  TaskFolderPage({this.tasks,this.taskFolder});

  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of(context);
    List<Task> list = [];
    tasks.forEach((element) {
      if(element.groupId == taskFolder.id){
        list.add(element);
      }
    });
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              MyAppbar(
                title: taskFolder.name,
                rightWidget: [
                  DefaultButton(
                    title: 'فعالیت جدید',
                    onPressed: () async {
                      Task t = await showDialog(
                        context: context,
                        builder: (context) => AddNewTask(groupId:taskFolder.id),
                      );
                      if (t != null) {
                        tasks.add(t);
                        refreshProvider.refresh();
                      }else{}
                    },
                  ),
                ],
                leftWidget: [
                  RotatedBox(quarterTurns: 3,child: MyIconButton(icon: MyIcons.ARROW_UP,onPressed: (){
                    Navigator.pop(context);
                  },))
                ],
              ),
              ChangeNotifierProvider.value(
                value: refreshProvider,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext c, int index) {
                      return TaskCard(task: list[index],tasks: tasks,);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
