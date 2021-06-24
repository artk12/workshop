import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/request/query/delete.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/publish_manager/taskFolderCard.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'dialog_add_new_folder_task.dart';

class TasksPage extends StatelessWidget {
  final List<Task> tasks;
  final List<TaskFolder> taskFolders;

  TasksPage({this.tasks, this.taskFolders});

  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of(context);
    var size = MediaQuery
        .of(context)
        .size;
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
                      (index) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChangeNotifierProvider.value(
                          value: refreshProvider,
                          child: GestureDetector(
                            onLongPress: () async {
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
                                        Text("حذف پوشه", style: Theme
                                            .of(context)
                                            .textTheme
                                            .headline2,),
                                        SizedBox(height: 15,),
                                        Text(
                                          "هشدار : با حذف کردن پوشه تمام فعالیت های درون آن حذف میشود.",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(height: 2),),
                                        SizedBox(height: 15,),
                                        DefaultButton(
                                          title: 'حذف',
                                          backgroundColor: Colors.red
                                              .withOpacity(0.5),
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                              if (check != null) {
                                MyShowSnackBar.showSnackBar(
                                    context, "لطفا صبر بکنید...");
                                String delete = Delete.deleteTaskFolder(
                                    taskFolders[index].id);
                                String res =
                                await MyRequest.simpleQueryRequest(
                                    'stockpile/runQuery.php', delete);
                                if(res.trim() == "OK"){
                                  taskFolders.removeWhere((element) => element.id == taskFolders[index].id);
                                  refreshProvider.refresh();
                                }
                              }
                            },
                            child: TaskFolderCard(
                              taskFolder: taskFolders[index],
                              tasksFolder: taskFolders,
                              tasks: tasks,
                            ),
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
