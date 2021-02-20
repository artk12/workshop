import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AssignTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    TextEditingController cutCode = new TextEditingController();
    TextEditingController quantity = new TextEditingController();

    ThemeData theme = Theme.of(context);
    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "اضافه تسک",
              style: theme.textTheme.headline3,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextField(
                          label: 'زمان فعالیت',
                          textInputType: TextInputType.number,
                          textEditingController: cutCode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextField(
                          label: 'مقدار',
                          textInputType: TextInputType.number,
                          textEditingController: quantity,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        "TPU\n\n00:00:44",
                        textAlign: TextAlign.center,
                      ),
                    ),
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
