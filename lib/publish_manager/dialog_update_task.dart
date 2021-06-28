import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';

class UpdateTask extends StatelessWidget {
  final Task task;

  UpdateTask({this.task});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController itemName = new TextEditingController(text: task.name);
    TextEditingController expert =
        new TextEditingController(text: task.expertTime);
    TextEditingController amateur =
        new TextEditingController(text: task.amateurTime);
    TextEditingController intern =
        new TextEditingController(text: task.internTime);
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    DialogMessageCubit messageCubit =
        DialogMessageCubit(DialogMessageState(message: ""));

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "به روز رسانی فعالیت",
                style: theme.textTheme.headline3,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextField(
                  hint: 'اسم فعالیت',
                  textInputType: TextInputType.text,
                  textEditingController: itemName,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextField(
                      label: "حرفه ای",
                      textInputType: TextInputType.number,
                      textEditingController: expert,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      label: "تازه کار",
                      textInputType: TextInputType.number,
                      textEditingController: amateur,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      label: "کارآموز",
                      textInputType: TextInputType.number,
                      textEditingController: intern,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder(
                  cubit: messageCubit,
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
                  child: SaveAndCancelButton(
                    cancelButton: (){Navigator.of(context).pop();},
                    saveButton: () async {
                      if (itemName.text.isEmpty ||
                          expert.text.isEmpty ||
                          intern.text.isEmpty ||
                          amateur.text.isEmpty) {
                        messageCubit.changeMessage(
                            "لطفا تمامی فیلدها را پر کنید...");
                      } else {
                        messageCubit.changeMessage("کمی صبر کنید...");
                        ignoreButtonCubit.update(true);
                        String query = Update.updateTask(
                            task.id,
                            itemName.text,
                            expert.text,
                            amateur.text,
                            intern.text);
                        String res = await MyRequest.simpleQueryRequest(
                            'runQueryId.php', query);
                        if (int.tryParse(res) != null) {
                          Task t = Task(
                              id: task.id,
                              internTime: intern.text,
                              expertTime: expert.text,
                              amateurTime: amateur.text,
                              name: itemName.text);
                          Navigator.pop(context, t);
                        } else {
                          ignoreButtonCubit.update(false);
                          messageCubit
                              .changeMessage("خطا در برقراری اتباط");
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
