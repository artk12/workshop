import 'package:flutter/material.dart';
import 'package:workshop/publish_manager/dialog_assign_task.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/personnel_assignment.dart';
import 'package:workshop/style/component/publish_manager/task_assignment.dart';

class AssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance
        .addPostFrameCallback((_) => showDialog(context: context, builder: (context)=>AssignTaskDialog(),barrierColor: Colors.transparent));

    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Row(
            children: [
              DefaultButton(title: 'تنظیم مجدد',),
              DefaultButton(title: 'وظیفه جدید',),
            ],
          ),
          SizedBox(height: 5,),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        TaskAssignmentCard(),
                    itemCount: 10,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        PersonnelAssignmentCard(),
                    itemCount: 10,
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
