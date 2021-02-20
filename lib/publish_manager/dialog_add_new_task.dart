import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AddNewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController itemName = new TextEditingController();
    TextEditingController expert = new TextEditingController();
    TextEditingController amateur = new TextEditingController();
    TextEditingController intern = new TextEditingController();
    IgnoreButtonCubit ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));

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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextField(
                hint: 'اسم فعالیت',
                textInputType: TextInputType.number,
                textEditingController: itemName,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DefaultTextField(
                    hint: 'حرفه ای',
                    textInputType: TextInputType.number,
                    textEditingController: expert,
                  ),
                ),
                Expanded(
                  child: DefaultTextField(
                    hint: 'تازه کار',
                    textInputType: TextInputType.number,
                    textEditingController: amateur,
                  ),
                ),
                Expanded(
                  child: DefaultTextField(
                    hint: 'کارآموز',
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
                              onPressed: () async {},
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
