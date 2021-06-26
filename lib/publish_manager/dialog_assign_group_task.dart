import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/publish_manager/assignment.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AssignGroupTaskDialog extends StatelessWidget {
  final NameAndSize nameAndSize;
  final List<AssignmentTask> assignTasks;

  AssignGroupTaskDialog({this.nameAndSize, this.assignTasks});

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                nameAndSize.name,
                style: theme.textTheme.headline3,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                    itemCount: nameAndSize.cutCodeAndLayer.length,
                    itemBuilder: (BuildContext c, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("کد برش : " +
                                nameAndSize.cutCodeAndLayer[index].cutCode),
                            Text("مقدار : " +
                                assignTasks
                                    .firstWhere((item) =>
                                        nameAndSize.cutCodeAndLayer[index]
                                                .cutCode ==
                                            item.cutCode &&
                                        item.name == nameAndSize.name)
                                    .number
                                    .toString()),
                            //" مقدار : " +
                            //                                 nameAndSize.cutCodeAndLayer[index].layer
                          ],
                        ),
                      );
                    }),
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
                        onPressed: () {
                          Navigator.of(context).pop(true);
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
      ),
    );
  }
}
