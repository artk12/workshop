import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/step1_holder.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/publish_manager/task_project_pieces.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewTaskDialogStep1 extends StatelessWidget {
  final List<Cut> cuts;
  final List<Task> tasks;

  NewTaskDialogStep1({this.cuts, this.tasks});

  @override
  Widget build(BuildContext context) {
    // List<String> tasksNames = ['زیپ','دکمه'];
    DialogMessageCubit dialogMessageCubit =
        new DialogMessageCubit(DialogMessageState(message: ""));
    SingleDropDownItemCubit tasksDropDownController = tasks.length == 0
        ? new SingleDropDownItemCubit(SingleDropDownItemState(value: ""))
        : new SingleDropDownItemCubit(
            SingleDropDownItemState(value: tasks.first.id));
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    TextEditingController projectCode = new TextEditingController();
    // TextEditingController quantity = new TextEditingController();

    ThemeData theme = Theme.of(context);

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "اضافه فعالیت",
              style: theme.textTheme.headline3,
            ),
            SizedBox(
              height: 20,
            ),
            DropDownBackground(
              child: CustomDropdownButtonHideUnderline(
                child: BlocBuilder(
                  cubit: tasksDropDownController,
                  builder:
                      (BuildContext context, SingleDropDownItemState state) =>
                          CustomDropdownButton<String>(
                    mainAxisAlignment: MainAxisAlignment.start,
                    items: tasks.map((Task value) {
                      return new CustomDropdownMenuItem<String>(
                        value: value.id,
                        child: new Text(
                          value.name,
                          style: TextStyle(
                              fontFamily: 'light', color: Colors.white),
                        ),
                      );
                    }).toList(),
                    value: state.value,
                    onChanged: (value) {
                      tasksDropDownController.changeItem(value);
                    },
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DefaultTextField(
                        label: 'کد پروژه',
                        textInputType: TextInputType.number,
                        textEditingController: projectCode,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: DefaultTextField(
                //       label: 'مقدار',
                //       textInputType: TextInputType.number,
                //       textEditingController: quantity,
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder(
                cubit: dialogMessageCubit,
                builder: (BuildContext context, DialogMessageState state) =>
                    Text(state.message)),
            SizedBox(
              height: 10,
            ),
            BlocBuilder(
              cubit: ignoreButtonCubit,
              builder: (BuildContext context, IgnoreButtonState state) =>
                  IgnorePointer(
                ignoring: state.ignore,
                child: Row(
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
                              style:
                                  MyTextStyle.iconStyle.copyWith(fontSize: 30),
                            ),
                          ),
                          onPressed: () async {

                            TaskPiecesProject p = await MyList()
                                .getPieces(projectCode.text.toString().trim());
                            // List<Pieces> body = await MyList()
                            //     .getPieces(projectCode.text.toString().trim());
                            if(p == null){
                              dialogMessageCubit
                                  .changeMessage("خطا در برقراری ارتباط");
                            } else if (p.pieces.isEmpty) {
                              dialogMessageCubit
                                  .changeMessage("کد برش یافت نشد.");
                            } else {
                              Task task = tasks.firstWhere((element) =>
                                  element.id == tasksDropDownController.state.value);
                              StepOneHolder stepOneHolder = new StepOneHolder(task:task,t:p);
                              Navigator.of(context).pop(stepOneHolder);
                            }

                            // try {
                            //   Cut cut = cuts.firstWhere(
                            //       (element) => element.cutCode == cutCode.text);
                            //   Task task = tasks.firstWhere((element) =>
                            //       element.id ==
                            //       tasksDropDownController.state.value);
                            //   String size = ',' + cut.project.size;
                            //   List<int> sizes = [];
                            //   while (true) {
                            //     String number = size.substring(
                            //         size.indexOf(','), size.indexOf(',') + 3);
                            //     sizes.add(
                            //         int.parse(number.replaceFirst(',', '')));
                            //     size = size.substring(size.indexOf(',') + 3);
                            //     if (size.length == 0) {
                            //       break;
                            //     }
                            //   }
                            //   int x = (int.parse(cut.realUsage) / sizes.length)
                            //       .round();
                            //   List<AssignmentTask> list = [];
                            //   for (int i = 0; i < sizes.length; i++) {
                            //     //TODO : Cut code
                            //     list.add(
                            //       AssignmentTask(
                            //         x,
                            //         task.internTime,
                            //         task.amateurTime,
                            //         task.expertTime,
                            //         task.name,
                            //         'cutCode'
                            //         // cut.cutCode + "-" + sizes[i].toString(),
                            //       ),
                            //     );
                            //   }
                            //   Navigator.of(context).pop(list);
                            // } catch (e) {
                            //   dialogMessageCubit
                            //       .changeMessage("کد برش یافت نشد.");
                            // }

                            // print(tasksDropDownController.state.value);
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
                              style:
                                  MyTextStyle.iconStyle.copyWith(fontSize: 30),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}