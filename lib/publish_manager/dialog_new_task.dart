import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> tasksNames = ['زیپ','دکمه'];
    SingleDropDownItemCubit tasks = new SingleDropDownItemCubit(SingleDropDownItemState(value: null));
    IgnoreButtonCubit ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    TextEditingController cutCode = new TextEditingController();
    TextEditingController quantity = new TextEditingController();


    ThemeData theme = Theme.of(context);
    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 20),
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
            DropDownBackground(
              child: CustomDropdownButtonHideUnderline(
                child: BlocBuilder(
                  cubit: tasks,
                  builder:
                      (BuildContext context, SingleDropDownItemState state) =>
                          CustomDropdownButton<String>(
                    mainAxisAlignment: MainAxisAlignment.start,
                    items: tasksNames.map((String value) {
                      return new CustomDropdownMenuItem<String>(
                        value: value,
                        child: new Text(
                          value,
                          style: TextStyle(fontFamily: 'light', color: Colors.white),
                        ),
                      );
                    }).toList(),
                    value: state.value,
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'کد برش',
                      textInputType: TextInputType.number,
                      textEditingController: cutCode,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'مقدار',
                      textInputType: TextInputType.number,
                      textEditingController: quantity,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height:10,),
            BlocBuilder(
              cubit: ignoreButtonCubit,
              builder: (BuildContext context,IgnoreButtonState state) => IgnorePointer(
                ignoring: state.ignore,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Container(),flex: 1,),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.green.withOpacity(0.4),),
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.green.withOpacity(0.4),),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(MyIcons.CHECK,style: MyTextStyle.iconStyle.copyWith(fontSize: 30),),
                          ),
                          onPressed: () async {},
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red.withOpacity(0.4),),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(MyIcons.CANCEL,style: MyTextStyle.iconStyle.copyWith(fontSize: 30),),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Expanded(child: Container(),flex: 1,),
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
