import 'dart:ui';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/icon_outline_button.dart';

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

    Widget space = SizedBox(
      height: 20,
    );

    return Scaffold(
      body: StockBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StockAppbar(
                title: 'اضافه به انبار',
              ),
              space,
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'آیتم جدید',
                    style: theme.textTheme.headline2!.copyWith(
                      fontFamily: 'bold',
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 15,
                        )
                      ],
                    ),
                  ),
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
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: nameCategoryCubit,
                            builder: (context, SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: nameCategory.map((String value) {
                                return new CustomDropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: TextStyle(
                                        fontFamily: 'light',
                                        color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              value: nameCategory
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                nameCategoryCubit.changeItem(value!);
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
                      label: 'شمارنده اول',
                      textEditingController: firstQuantifier,
                      textInputType: TextInputType.number,
                    ),
                  )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: categoryCubit,
                            builder: (context, SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: category.map((String value) {
                                return new CustomDropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(
                                    value,
                                    style: TextStyle(
                                        fontFamily: 'light',
                                        color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              value: category
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                categoryCubit.changeItem(value!);
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
                  Expanded(child:Container()),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconOutlineButton(
                    color: Colors.green.withOpacity(0.4),
                    icon: Icons.check,
                    onPressed: () async {
                      if (newItemName.text.isEmpty ||
                          firstQuantifier.text.isEmpty ||
                          warning.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('لطفا تمامی فیلدها رو پر کنید.'),
                        ));
                      } else {
                        String quantify = category
                            .where((element) =>
                                element == categoryCubit.state.value)
                            .first;
                        String nameQuantify = nameCategory
                            .where((element) =>
                                element == nameCategoryCubit.state.value)
                            .first;
                        String res = await MyRequest.addNewItems(
                            newItemName.text,
                            nameQuantify,
                            firstQuantifier.text,
                            quantify,
                            warning.text);
                        print(res);
                      }
                    },
                  ),
                  IconOutlineButton(
                    color: Colors.red.withOpacity(0.4),
                    icon: Icons.close,
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
