import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/cutter/new_cut_dialog_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/cutter/cutter_page.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/cutter/cut_detail.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewCutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    NewCutDialogCubit newCutDialogCubit =
        new NewCutDialogCubit(NewCutDialogState());
    TextEditingController barcode = new TextEditingController();
    TextEditingController projectCode = new TextEditingController();

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // DefaultTextField(label: 'کالیته',),
            SizedBox(
              height: 10,
            ),
            Text(
              "برش جدید",
              style: theme.textTheme.headline2,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: DefaultTextField(
                  hint: 'بارکد طاقه',
                  textEditingController: barcode,
                )),
                Expanded(
                    child: DefaultTextField(
                  hint: 'کد پروژه',
                  textEditingController: projectCode,
                ))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder(
              cubit: newCutDialogCubit,
              builder: (BuildContext context, NewCutDialogState state) => Text(
                state.message,
                style: theme.textTheme.headline4,
              ),
            ),
            SizedBox(
              height: 30,
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
                            newCutDialogCubit.changeMessage('کمی صبرکنید...');
                            ignoreButtonCubit.update(true);
                            CutDetail result = await MyRequest.getCutDetail(
                                barcode.text, projectCode.text);
                            if (result == null) {
                              newCutDialogCubit.changeMessage('کالیته و کد پروژه یافت نشد.');
                              ignoreButtonCubit.update(false);
                            } else {
                              if (result.projectId == null) {
                                newCutDialogCubit.changeMessage('پروژه یافت نشد.');
                                ignoreButtonCubit.update(false);
                              } else if (result.fabricId == null) {
                                newCutDialogCubit.changeMessage('بارکد یافت نشد.');
                                ignoreButtonCubit.update(false);
                              } else {
                                CutReturn cutReturn = await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CutterPage(
                                      cutDetail: result,
                                    ),
                                  ),
                                );
                                Navigator.of(context).pop(cutReturn);
                              }
                            }
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
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
