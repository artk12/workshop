
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/style/component/personnel/task_item.dart';

class MyTaskList extends StatelessWidget {
  final User user;
  final ScoreCubit scoreCubit;
  MyTaskList({this.user,this.scoreCubit});
  @override
  Widget build(BuildContext context) {
    TaskItemProvider provider = Provider.of(context);

    return ListView.builder(
      itemCount: provider.tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return provider.checks[index].isDone?Container():TaskItem(
          scoreCubit: scoreCubit,
          provider: provider,
          user: user,
          assignPersonnel: provider.tasks[index],
          maxWidth: double.maxFinite,
          index: index + 1,
          total: provider.tasks.length,
        );
      },
    );
  }
}
