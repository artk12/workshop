import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/assign_personnel.dart';
import 'package:workshop/bloc/publishManager/assign_task.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/provider/new_task_page_provider.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/new_tasks_page.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/personnel_assignment.dart';
import 'package:workshop/style/component/publish_manager/task_assignment.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

import 'dialog_assign_task.dart';

class AssignmentPage extends StatelessWidget {
  final List<Cut> cuts;
  final List<Task> tasks;
  final List<TaskFolder> taskFolders;
  final List<Personnel> personnel;
  final AssignTaskCubit assignTaskCubit;
  final AssignPersonnelCubit assignPersonnelCubit;
  final PageController pageController;
  final PublishManagerPageController streamPageController;

  AssignmentPage(
      {this.cuts,
      this.tasks,
      this.personnel,
      this.assignPersonnelCubit,
      this.assignTaskCubit,
      this.taskFolders,
      this.pageController,
      this.streamPageController});

  @override
  Widget build(BuildContext context) {
    GlobalKey scaffoldKey = new GlobalKey<ScaffoldState>();
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => showDialog(context: context, builder: (context)=>AssignTaskDialog(),barrierColor: Colors.transparent));

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DefaultButton(
                    title: 'ثبت',
                    backgroundColor: Colors.green.withOpacity(0.4),
                    onPressed: () async {
                      if (assignPersonnelCubit.state.assignments.length == 0) {
                        MyShowSnackBar.showSnackBar(context,
                            "هیچ فعالیتی برای نیروی کار در نظر گرفته نشده است.");
                      } else {
                        List<Map> mapList = [];
                        DateTime dateTime = DateTime.now();
                        assignPersonnelCubit.state.assignments
                            .forEach((element) {
                          Map map = {};
                          map['name'] = element.name;
                          map['assignDateTime'] =
                              dateTime.toString().substring(0, 19);
                          map['time'] = element.time;
                          map['cutCode'] = element.cutCode;
                          map['number'] = element.number;
                          map['personnelId'] = element.personnel.id;
                          double maxScore = 0;
                          if (element.personnel.level == "حرفه ای") {
                            maxScore = element.time * 1.5;
                          } else if (element.personnel.level == "تازه کار") {
                            maxScore = element.time * 1.0;
                          } else {
                            maxScore = element.time + 0.5;
                          }
                          map['max_score'] = maxScore;
                          mapList.add(map);
                        });
                        MyShowSnackBar.showSnackBar(context, "کمی صبر کنید...");
                        await MyRequest.insertAssignRequest(
                            jsonEncode(mapList));
                        MyShowSnackBar.hideSnackBar(context);
                        streamPageController.pageView = 0;
                        pageController.animateToPage(0,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                  ),
                  DefaultButton(
                    title: 'لغو',
                    backgroundColor: Colors.red.withOpacity(0.4),
                    onPressed: () async {
                      streamPageController.pageView = 0;
                      assignTaskCubit.clear();
                      pageController.animateToPage(0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                  ),
                  DefaultButton(
                    title: 'تنظیم مجدد',
                    onPressed: () {
                      assignTaskCubit.refresh();
                      assignPersonnelCubit.refresh();
                    },
                  ),
                  DefaultButton(
                    title: 'فعالیت جدید',
                    onPressed: () async {
                      //TODO : Cut code
                      //StepOneHolder r = await
                      // List<AssignmentTask> t = await showDialog(
                      //   context: context,
                      //   builder: (context) => NewTaskDialogStep1(
                      //     cuts: cuts,
                      //     tasks: tasks,
                      //     dialogContext: context,
                      //   ),
                      // );
                      //   if (t != null) {
                      //     assignTaskCubit.addTask(t);
                      //   }
                      // }
                      List<AssignmentTask> t = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => ChangeNotifierProvider.value(
                            value: NewTaskPageProvider(tasks),
                            child: NewTaskPage(
                              cuts: cuts,
                              tasks: tasks,
                              tasksFolder: taskFolders,
                            ),
                          ),
                        ),
                      );
                      if(t != null){
                        assignTaskCubit.addTask(t);
                      }

                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Row(
                children: [
                  BlocBuilder(
                    cubit: assignTaskCubit,
                    builder: (BuildContext context, AssignTaskState state) {
                      List<String> titles = [];
                      state.assignTaskUpdate.forEach((element) {
                        String c = element.cutCode.substring(0,element.cutCode.lastIndexOf('-'));
                        if(!titles.contains(c)){
                          titles.add(c);
                        }
                      });
                      List<DragTaskGroup> myList = [];
                      titles.forEach((element) {
                        myList.add(
                          DragTaskGroup(
                            title: element,
                            tasks: state.assignTaskUpdate.where((item) {
                              String c = item.cutCode.substring(0,item.cutCode.lastIndexOf('-'));
                              return c == element;
                            }).toList()
                          )
                        );
                      });
                      // print(titles.length);
                      return Expanded(
                        flex: 2,
                        child: myList.length == 0 ?Container() :ListView(
                          children: List.generate(myList.length, (i) => ExpansionTile(
                            title: Text(myList[i].title,style: Theme.of(context).textTheme.headline6,),
                            trailing: SizedBox.shrink(),
                            children: List.generate(myList[i].tasks.length, (j) => Draggable(
                                data: myList[i].tasks[j],
                                feedback: TaskAssignmentCard(
                                  isDragging: true,
                                  name: myList[i].tasks[j].name,
                                  cutCode: myList[i].tasks[j].cutCode,
                                ),
                                child: TaskAssignmentCard(
                                  name: myList[i].tasks[j].name,
                                  cutCode: myList[i].tasks[j].cutCode,
                                  number: myList[i].tasks[j].number,
                                ))),

                          ),),
                        ),
                      );
                    },
                  ),
                  Expanded(
                    flex: 3,
                    child: BlocBuilder(
                      cubit: assignPersonnelCubit,
                      builder:
                          (BuildContext context, AssignPersonnelState state) =>
                              ListView.builder(
                        itemBuilder: (context, index) => DragTarget(
                          builder: (BuildContext context,
                                  List<Object> candidateData,
                                  List<dynamic> rejectedData) =>
                              PersonnelAssignmentCard(
                            personnel: personnel[index],
                            assignPersonnelTasks: state.assignments
                                .where((element) =>
                                    element.personnel == personnel[index])
                                .toList(),
                          ),
                          onAccept: (AssignmentTask data) async {
                            AssignTaskPersonnel a = await showDialog(
                                context: context,
                                builder: (context) => AssignTaskDialog(
                                    alignmentTask: data,
                                    personnel: personnel[index]));
                            if (a != null) {
                              assignPersonnelCubit.update(a);
                              assignTaskCubit.updateTask(
                                  a.cutCode, a.number, a.name);
                            }
                          },
                        ),
                        itemCount: personnel.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class DragTaskGroup{
  final String title;
  final List<AssignmentTask> tasks;
  DragTaskGroup({this.tasks,this.title});
}
// itemBuilder: (context, index) => Draggable(
//     data: state.assignTaskUpdate[index],
//     feedback: TaskAssignmentCard(
//       isDragging: true,
//       name: state.assignTaskUpdate[index].name,
//       cutCode: state.assignTaskUpdate[index].cutCode,
//     ),
//     child: TaskAssignmentCard(
//       name: state.assignTaskUpdate[index].name,
//       cutCode: state.assignTaskUpdate[index].cutCode,
//       number: state.assignTaskUpdate[index].number,
//     )),
// itemCount: state.assignTaskUpdate.length,