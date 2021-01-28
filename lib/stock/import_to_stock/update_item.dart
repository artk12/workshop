import 'dart:ui';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/icon_outline_button.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class UpdateItem extends StatelessWidget {
  final Item item;
  UpdateItem({this.item});
  @override
  Widget build(BuildContext context) {
    List<String> quantify = ['کیلوگرم', 'متر', 'بسته'];
    List<String> category = ['خرج کار', 'بسته بندی'];
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));

    final TextEditingController firstQuantifier =
        new TextEditingController(text: item.quantifierOne);
    final TextEditingController warning =
        new TextEditingController(text: item.warning);
    SingleDropDownItemCubit categoryCubit = new SingleDropDownItemCubit(
        SingleDropDownItemState(value: item.category));

    SingleDropDownItemCubit quantifyCubit = new SingleDropDownItemCubit(
        SingleDropDownItemState(value: item.quantify));

    ThemeData theme = Theme.of(context);
    Widget space = SizedBox(height: 20);

    Widget itemNameWidget = Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          item.name,
          style: theme.textTheme.headline2.copyWith(
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
              itemNameWidget,
              space,
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        textInputType: TextInputType.number,
                        textEditingController: firstQuantifier,
                        label: 'تعداد ورود',
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: BlocBuilder(
                          cubit: categoryCubit,
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: BlocBuilder(
                          cubit: quantifyCubit,
                          builder: (context, SingleDropDownItemState state) =>
                              CustomDropdownButtonHideUnderline(
                            child: CustomDropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: quantify.map((String value) {
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
                              value: quantify
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                quantifyCubit.changeItem(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      IconOutlineButton(
                        color: Colors.green.withOpacity(0.4),
                        icon: Icons.check,
                        onPressed: () async {
                          if (firstQuantifier.text.isEmpty ||
                              warning.text.isEmpty) {
                            MyShowSnackBar.showSnackBar(
                                context, "لطفا تمامی فیلدها را پر کنید.");
                          } else if (int.parse(warning.text) >
                              int.parse(firstQuantifier.text)) {
                            MyShowSnackBar.showSnackBar(context,
                                "تعداد هشدار شما بیشتر از تعداد ورودی است.");
                          } else if (int.parse(item.quantifierOne) >
                              int.parse(firstQuantifier.text)) {
                            MyShowSnackBar.showSnackBar(context,
                                "تعداد ورودی کمتر از قبل است لطفابرای خروج کالا از انبار از صفحه اصلی آیکون خروجی وارد شوید.");
                          } else {
                            MyShowSnackBar.showSnackBar(
                                context, "کمی صبرکنید...");
                            String body;
                            int currentQuantifier =
                                int.parse(firstQuantifier.text);
                            int itemQuantifier =
                                int.parse(item.quantifierOne);
                            String update = Update.queryUpdateItemInStockpile(
                                item.id,
                                firstQuantifier.text,
                                quantifyCubit.state.value,
                                categoryCubit.state.value,
                                warning.text);
                            String insert = Insert.queryInsertInputToLog(
                                item.id,
                                int.parse(firstQuantifier.text) -
                                    int.parse(item.quantifierOne));
                            ignoreButtonCubit.update(true);
                            if (currentQuantifier - itemQuantifier == 0) {
                              //update
                              body = await MyRequest.simpleQueryRequest(
                                  'stockpile/runQuery.php', update);
                            } else {
                              //insert update
                              body = await MyRequest.simple2QueryRequest(
                                  'stockpile/run2Query.php', update, insert);
                            }
                            if (body == "OK") {
                              MyShowSnackBar.hideSnackBar(context);
                              ignoreButtonCubit.update(false);
                              Navigator.pop(context);
                            }
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
