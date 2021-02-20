import 'package:flutter/material.dart';
import 'package:workshop/publish_manager/dialog_add_new_task.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/publish_manager/taskCard.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    final double itemWidth = size.width / 2;

    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => AddNewTask(),
        barrierColor: Colors.transparent));

    return Container(
      height: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Row(
            children: [
              DefaultButton(
                title: 'فعالیت جدید',
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
              children: List.generate(50, (index) => TaskCard()),
            ),
          )
        ],
      ),
    );
  }
}
