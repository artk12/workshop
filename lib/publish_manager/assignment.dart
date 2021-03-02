import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/publishManager/assign_personnel.dart';
import 'package:workshop/bloc/publishManager/assign_task.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/dialog_new_task.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/personnel_assignment.dart';
import 'package:workshop/style/component/publish_manager/task_assignment.dart';

import 'dialog_assign_task.dart';

class AssignmentPage extends StatelessWidget {
  final List<Cut> cuts;
  final List<Task> tasks;
  final List<Personnel> personnel;
  AssignmentPage({this.cuts, this.tasks, this.personnel});

  @override
  Widget build(BuildContext context) {
    AssignTaskCubit assignTaskCubit =
        AssignTaskCubit(AssignTaskState(assignTaskUpdate: []));
    AssignPersonnelCubit assignPersonnelCubit =
        new AssignPersonnelCubit(AssignPersonnelState(assignments: []));
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => showDialog(context: context, builder: (context)=>AssignTaskDialog(),barrierColor: Colors.transparent));

    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Row(
            children: [
              DefaultButton(
                title: 'تنظیم مجدد',
                onPressed: (){
                  assignTaskCubit.refresh();
                  assignPersonnelCubit.refresh();
                },
              ),
              DefaultButton(
                title: 'فعالیت جدید',
                onPressed: () async {
                  List<AssignmentTask> t = await showDialog(
                    context: context,
                    builder: (context) => NewTaskDialog(
                      cuts: cuts,
                      tasks: tasks,
                    ),
                  );
                  if (t != null) {
                    assignTaskCubit.addTask(t);
                  }
                },
              ),
            ],
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
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => Draggable(
                            data: state.assignTaskUpdate[index],
                            feedback: TaskAssignmentCard(
                              isDragging: true,
                              name: state.assignTaskUpdate[index].name,
                              cutCode: state.assignTaskUpdate[index].cutCode,
                            ),
                            child: TaskAssignmentCard(
                              name: state.assignTaskUpdate[index].name,
                              cutCode: state.assignTaskUpdate[index].cutCode,
                              number: state.assignTaskUpdate[index].number,
                            )),
                        itemCount: state.assignTaskUpdate.length,
                      ),
                    );
                  },
                ),
                Expanded(
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
                          // cutCode: c,
                          assignPersonnelTasks: state.assignments.where(
                              (element) =>
                                  element.personnel == personnel[index]).toList(),
                        ),
                        onAccept: (AssignmentTask data) async {

                          AssignTaskPersonnel a = await showDialog(
                              context: context,
                              builder: (context) => AssignTaskDialog(
                                  alignmentTask: data,
                                  personnel: personnel[index]));
                          if(a != null){
                            assignPersonnelCubit.update(a);
                            assignTaskCubit.updateTask(a.cutCode, a.number,a.name);
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
    );
  }
}
