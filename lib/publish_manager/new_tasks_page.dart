import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/publishManager/cut_code_assign_bloc.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/pieces.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/publish_manager/task_project_pieces.dart';
import 'package:workshop/provider/new_task_page_provider.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/publish_manager/tasks_in_assignment.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewTaskPage extends StatefulWidget {
  final List<Cut> cuts;
  final List<Task> tasks;
  final List<TaskFolder> tasksFolder;

  NewTaskPage({this.tasks, this.cuts, this.tasksFolder});

  @override
  _NewTaskPageState createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  DialogMessageCubit dialogMessageCubit;
  CutCodeAssignCubit cubit;
  TextEditingController projectCode = new TextEditingController();
  IgnoreButtonCubit ignoreButtonCubit;

  @override
  void initState() {
    dialogMessageCubit =
        new DialogMessageCubit(DialogMessageState(message: ""));
    ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NewTaskPageProvider provider = Provider.of(context);
    ThemeData theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;

    return Scaffold(
      bottomSheet: Container(
        height: 60,
        color: Colors.black38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.resolveWith(
                            (states) => Colors.green.withOpacity(0.4),
                      ),
                      backgroundColor:
                      MaterialStateProperty.resolveWith(
                            (states) => Colors.green.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      MyIcons.CHECK,
                      style: MyTextStyle.iconStyle
                          .copyWith(fontSize: 26),
                    ),
                    onPressed: () async {
                      List<CutCodeCheck> checksList =
                      cubit.getCutCodeChecks();
                      List<Pieces> pieces = [];
                      List<AssignmentTask> assignmentTaskList = [];
                      List<Task> checksTask = [];
                      provider.taskChecksAssign.forEach((element) {
                        if(element.check){
                          checksTask.add(element.task);
                        }
                      });
                      checksList.forEach((item) {
                        try {
                          pieces.add(provider.p.pieces.firstWhere(
                                  (element) => element.cutCode == item.cutCode));
                        } catch (e) {}
                      });
                      if(pieces.isEmpty){
                        MyShowSnackBar.showSnackBar(context, "کد برشی انتخاب نشده است.");
                      }else if(checksTask.isEmpty){
                        MyShowSnackBar.showSnackBar(context, "فعالیتی انتخاب نشده است.");
                      }else{
                        checksTask.forEach((task) {
                          pieces.forEach((item) {
                            String shortStyleCode = item.cutCode
                                .substring(item.cutCode.lastIndexOf('-') + 1);
                            try {
                              List<SizesAndStyle> sizes = provider.p.project.sizeAndStyle
                                  .where((element) =>
                              element.shortStyleName == shortStyleCode)
                                  .toList();
                              // int x =
                              //     (int.parse(item.layer) / sizes.length).round();
                              int x = (int.parse(item.layer));
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
                        });
                        Navigator.of(context).pop(assignmentTaskList);
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.resolveWith(
                            (states) => Colors.red.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      MyIcons.CANCEL,
                      style: MyTextStyle.iconStyle
                          .copyWith(fontSize: 26),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
          ],
        )
      ),
      // bottomNavigationBar: Container(color: Colors.green,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 250,
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
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder(
                      cubit: dialogMessageCubit,
                      builder: (BuildContext context, DialogMessageState s) {
                        return Text(
                          s.message,
                          style: theme.textTheme.headline4,
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.7))),
                    child: TextButton(
                      onPressed: () async {
                        dialogMessageCubit.changeMessage("لطفا صبر کنید...");
                        TaskPiecesProject p = await MyList()
                            .getPieces(projectCode.text.toString().trim());
                        dialogMessageCubit.changeMessage("پروژه یافت شد.");
                        List<CutCodeCheck> list = [];
                        p.pieces.forEach((element) {
                          list.add(CutCodeCheck(
                              cutCode: element.cutCode, check: false));
                        });
                        cubit = new CutCodeAssignCubit(
                            CutCodeAssignState(cutCodeChecks: list));
                        provider.updatePiecesProject(p);
                      },
                      child: Text(
                        'جستجو',
                        style: theme.textTheme.headline2,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  provider.p == null
                      ? Container()
                      : Directionality(
                          textDirection: TextDirection.ltr,
                          child: BlocBuilder(
                            cubit: cubit,
                            builder: (BuildContext context,
                                    CutCodeAssignState state) =>
                                GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: (itemWidth / itemHeight),
                              controller:
                                  new ScrollController(keepScrollOffset: false),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: List.generate(
                                  provider.p.pieces.length,
                                  (i) => CheckboxListTile(
                                        title: Text(
                                            provider.p.pieces[i].cutCode,
                                            style: theme.textTheme.headline4),
                                        value: state.cutCodeChecks[i].check,
                                        onChanged: (check) {
                                          cubit.changeStyleCodeCheck(
                                              provider.p.pieces[i].cutCode,
                                              check);
                                        },
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                      )),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: List.generate(
                      widget.tasksFolder.length,
                      (index) => TaskInAssignment(
                        taskFolder: widget.tasksFolder[index],
                        tasks: provider.taskChecksAssign
                            .where((element) =>
                                element.task.groupId ==
                                widget.tasksFolder[index].id)
                            .toList(),
                        theme: theme,
                        provider: provider,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
