import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/publishManager/cut_code_assign_bloc.dart';
import 'package:workshop/module/publish_manager/pieces.dart';
import 'package:workshop/module/publish_manager/step1_holder.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewTaskDialogStep2 extends StatelessWidget {
  final StepOneHolder stepOneHolder;

  NewTaskDialogStep2({this.stepOneHolder});

  @override
  Widget build(BuildContext context) {
    List<CutCodeCheck> list = [];
    stepOneHolder.t.pieces.forEach((element) {
      list.add(CutCodeCheck(cutCode: element.cutCode, check: false));
    });
    CutCodeAssignCubit cubit =
        new CutCodeAssignCubit(CutCodeAssignState(cutCodeChecks: list));
    ThemeData theme = Theme.of(context);

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                height: 300,
                child: BlocBuilder(
                  cubit: cubit,
                  builder: (BuildContext context, CutCodeAssignState state) =>
                      ListView.builder(
                    itemCount: stepOneHolder.t.pieces.length,
                    itemBuilder: (BuildContext c, int i) {
                      return CheckboxListTile(
                        title: Text(stepOneHolder.t.pieces[i].cutCode,
                            style: theme.textTheme.headline4),
                        value: state.cutCodeChecks[i].check,
                        onChanged: (check) {
                          cubit.changeStyleCodeCheck(
                              stepOneHolder.t.pieces[i].cutCode, check);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green.withOpacity(0.4),
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green.withOpacity(0.4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          MyIcons.CHECK,
                          style: MyTextStyle.iconStyle.copyWith(fontSize: 30),
                        ),
                      ),
                      onPressed: () async {
                        Task task = stepOneHolder.task;
                        List<CutCodeCheck> checksList =
                            cubit.getCutCodeChecks();
                        List<Pieces> pieces = [];
                        List<AssignmentTask> assignmentTaskList = [];
                        checksList.forEach((item) {
                          try {
                            pieces.add(stepOneHolder.t.pieces.firstWhere(
                                (element) => element.cutCode == item.cutCode));
                          } catch (e) {}
                        });
                        pieces.forEach((item) {
                          String shortStyleCode = item.cutCode
                              .substring(item.cutCode.lastIndexOf('-') + 1);
                          try {
                            List<SizesAndStyle> sizes = stepOneHolder
                                .t.project.sizeAndStyle
                                .where((element) =>
                                    element.shortStyleName == shortStyleCode)
                                .toList();
                            int x =
                                (int.parse(item.layer) / sizes.length).round();
                            sizes.forEach((element) {
                              assignmentTaskList.add(AssignmentTask(
                                x,
                                task.internTime,
                                task.amateurTime,
                                task.expertTime,
                                task.name,
                                item.cutCode + "-" + element.size,
                              ));
                            });
                          } catch (e) {
                            print(e);
                          }
                        });
                        Navigator.pop(context,assignmentTaskList);
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red.withOpacity(0.4),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          MyIcons.CANCEL,
                          style: MyTextStyle.iconStyle.copyWith(fontSize: 30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
