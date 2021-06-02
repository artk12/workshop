import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AddNewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<String> category = ['کیلوگرم', 'متر', 'بسته'];
    List<String> nameCategory = ['خرج کار', 'بسته بندی'];
    final TextEditingController newItemName = new TextEditingController();
    final TextEditingController firstQuantifier = new TextEditingController();
    final TextEditingController warning = new TextEditingController();

    SingleDropDownItemCubit nameCategoryCubit =
        new SingleDropDownItemCubit(SingleDropDownItemState(value: 'خرج کار'));
    SingleDropDownItemCubit categoryCubit =
        new SingleDropDownItemCubit(SingleDropDownItemState(value: 'کیلوگرم'));
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));

    Widget space = SizedBox(
      height: 20,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: 'اضافه به انبار',
              ),
              space,
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('آیتم جدید', style: MyTextStyle.disPlay1),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: theme.primaryColor),
                  ),
                ),
              ),
              space,
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'اسم آیتم',
                      textEditingController: newItemName,
                    ),
                  )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: DropDownBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: nameCategoryCubit,
                            builder: (context, SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: nameCategory.map((String value) {
                                return new CustomDropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: theme.textTheme.headline6,
                                  ),
                                );
                              }).toList(),
                              value: nameCategory
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                nameCategoryCubit.changeItem(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'تعداد',
                      textEditingController: firstQuantifier,
                      textInputType: TextInputType.number,
                    ),
                  )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: DropDownBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: categoryCubit,
                            builder: (context, SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: category.map((String value) {
                                return new CustomDropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: theme.textTheme.headline6,
                                  ),
                                );
                              }).toList(),
                              value: category
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                categoryCubit.changeItem(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'تعداد هشدار',
                      textEditingController: warning,
                      textInputType: TextInputType.number,
                    ),
                  )),
                  Expanded(child: Container()),
                ],
              ),
              SizedBox(
                height: 70,
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
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Colors.green.withOpacity(0.4),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) => Colors.green.withOpacity(0.4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                MyIcons.CHECK,
                                style: MyTextStyle.iconStyle
                                    .copyWith(fontSize: 30),
                              ),
                            ),
                            onPressed: () async {
                              if (newItemName.text.isEmpty ||
                                  firstQuantifier.text.isEmpty ||
                                  warning.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('لطفا تمامی فیلدها رو پر کنید.'),
                                ));
                              } else {
                                ignoreButtonCubit.update(true);
                                MyShowSnackBar.showSnackBar(
                                    context, "کمی صبرکنید...");
                                String quantify = category
                                    .where((element) =>
                                        element == categoryCubit.state.value)
                                    .first;
                                String nameQuantify = nameCategory
                                    .where((element) =>
                                        element ==
                                        nameCategoryCubit.state.value)
                                    .first;
                                String res = await MyRequest.addNewItem(
                                    newItemName.text,
                                    nameQuantify,
                                    firstQuantifier.text,
                                    quantify,
                                    warning.text);
                                if (res.trim() == "OK") {
                                  ignoreButtonCubit.update(false);
                                  MyShowSnackBar.hideSnackBar(context);
                                  Navigator.of(context).pop();
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
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => Colors.red.withOpacity(0.4),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  MyIcons.CANCEL,
                                  style: MyTextStyle.iconStyle
                                      .copyWith(fontSize: 30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
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
