import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/style/component/personnel/task_item.dart';

class MyTaskList extends StatelessWidget {
  final User user;
  final ScoreCubit scoreCubit;
  MyTaskList({this.user, this.scoreCubit});

  @override
  Widget build(BuildContext context) {
    TaskItemProvider provider = Provider.of(context);
    return provider.checks.isEmpty
        ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
                SizedBox(height: 25,),
                Text("لطقا کمی منتظر بمانید",style: Theme.of(context).textTheme.headline4,)
              ],
            ),
          )
        : ListView.builder(
            itemCount: provider.checks.length,
            cacheExtent: 0,
            itemBuilder: (BuildContext context, int index) {
              return provider.checks[index].isDone
                  ? Container()
                  : TaskItem(
                      scoreCubit: scoreCubit,
                      provider: provider,
                      user: user,
                      assignPersonnel: provider.tasks[index],
                      maxWidth: double.maxFinite,
                      index: index + 1,
                      cubit: provider.checks[index].cubit,
                      total: provider.tasks.length,
                    );
            },
          );
  }
}
