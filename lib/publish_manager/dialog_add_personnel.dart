import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AddPersonnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController name = new TextEditingController();
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));

    return DialogBg(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "اضافه فعالیت",
                style: theme.textTheme.headline3,
              ),
              SizedBox(height: 10),
              CircleAvatar(
                radius: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextField(
                  hint: 'اسم فعالیت',
                  textInputType: TextInputType.number,
                  textEditingController: name,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'کد ملی',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      hint: 'نام پدر',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'تاریخ تولد',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      hint: 'تاریخ استخدام',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'سمت',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      hint: 'سطح',
                      textInputType: TextInputType.number,
                      textEditingController: name,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
      ),
    );
  }
}
