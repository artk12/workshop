import 'dart:ui';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/icon_outline_button.dart';

class AddAvailableItem extends StatelessWidget {
  final ItemNameAvailable? availableItem;
  AddAvailableItem({this.availableItem});
  @override
  Widget build(BuildContext context) {
    List<String> category = ['کیلوگرم', 'متر', 'بسته'];
    final TextEditingController firstQuantifier = new TextEditingController();
    final TextEditingController secondQuantifier = new TextEditingController();
    final TextEditingController warning = new TextEditingController();

    SingleDropDownItemCubit singleDropDownItemCubit =
        new SingleDropDownItemCubit(
            SingleDropDownItemState(value: category[0]));
    ThemeData theme = Theme.of(context);
    Widget space = SizedBox(
      height: 20,
    );
    Widget item = Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          availableItem!.name,
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
              item,
              space,
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      textInputType: TextInputType.number,
                      textEditingController: firstQuantifier,
                      label: 'شمارنده اول',
                    ),
                  )),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: BlocBuilder(
                          cubit: singleDropDownItemCubit,
                          builder: (context, SingleDropDownItemState state) =>
                              CustomDropdownButtonHideUnderline(
                            child: CustomDropdownButton<String>(
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
                                singleDropDownItemCubit.changeItem(value!);
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
                        label: 'شمارنده دوم',
                        textEditingController: secondQuantifier,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'تعداد هشدار',
                        textEditingController: warning,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
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
                      String quantify = category
                          .where((element) =>
                              element == singleDropDownItemCubit.state.value)
                          .first;
                      if (firstQuantifier.text.isEmpty ||
                          secondQuantifier.text.isEmpty ||
                          warning.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'لطفا تمامی فیلدها را پر کنید.',
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        );
                      } else {
                        DateTime dateTime = DateTime.now();
                        String query = Insert.queryAddAvailableItemToStockpile(
                            availableItem!.id,
                            firstQuantifier.text,
                            quantify,
                            secondQuantifier.text,
                            warning.text,
                            dateTime.year,
                            dateTime.month,
                            dateTime.day);
                        String body = await MyRequest.simpleQueryRequest(
                            'stockpile/insert.php', query);
                        print(body);
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
