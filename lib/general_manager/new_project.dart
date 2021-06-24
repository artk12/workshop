import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/general_manager/style_code_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/general_manager/styleCode.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/background_widget.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewProject extends StatelessWidget {
  final List<Project> projects;
  final List<StyleCode> styleCodes;
  final RefreshProvider refreshProvider;

  NewProject({this.projects, this.refreshProvider, this.styleCodes});

  @override
  Widget build(BuildContext context) {
    TextEditingController orderController = new TextEditingController();
    TextEditingController brandController = new TextEditingController();
    TextEditingController rollController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    Widget space(double height) => SizedBox(height: height);
    IgnoreButtonCubit ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    NewProjectSizeCubit cubit = new NewProjectSizeCubit(NewProjectSizeState(list: []));
    ThemeData theme = Theme.of(context);

    List<StyleCodeNames> codes = [];
    styleCodes.sort((a,b)=>int.parse(a.shortName).compareTo(int.parse(b.shortName)));
    styleCodes.forEach((element) {
      codes.add(StyleCodeNames(
          name: element.name, shortName: element.shortName, check: false));
    });
    // codes.sort((a,b)=>int.parse(b).compareTo(other))
    StyleCodeCubit styleCodeCubit =
        new StyleCodeCubit(StyleCodeState(styleChecks: codes));

    // List<BlocBuilder> styleCodes = [];
    // for(int i = 0 ; i < styleCodesName.length ; i++){
    //
    //   styleCodes.add(BlocBuilder(
    //     cubit:styleCodeCubit,
    //     builder:(BuildContext context,StyleCodeState state)=> CheckboxListTile(
    //       title: Text(styleCodesName[i],style: theme.textTheme.headline4),
    //       value: true,
    //       onChanged: (newValue) {
    //
    //       },
    //       controlAffinity: ListTileControlAffinity.leading,
    //     ),
    //   ),);
    // }

    Widget addSize(NewProjectSizeCubit cubit) {
      TextEditingController textEditingController;
      return GestureDetector(
        // styleCodeCubit.state.styleChecks.forEach((element) { })
        onTap: () {
          textEditingController = new TextEditingController();
          SingleDropDownItemCubit singleDropDownItemCubit;
          List<StyleCodeNames> list = [];
          try {
            list = styleCodeCubit.state.styleChecks
                .where((element) => element.check == true)
                .toList();
            singleDropDownItemCubit = new SingleDropDownItemCubit(
                SingleDropDownItemState(value: list[0].name));
          } catch (e) {}

          if (list.isNotEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogBg(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 84,
                          child: DropDownBackground(
                            child: BlocBuilder(
                              cubit: singleDropDownItemCubit,
                              builder:
                                  (context, SingleDropDownItemState state) =>
                                      CustomDropdownButtonHideUnderline(
                                child: CustomDropdownButton<String>(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  items: styleCodeCubit.state.styleChecks
                                      .where((element) => element.check)
                                      .toList()
                                      .map((StyleCodeNames value) {
                                    return new CustomDropdownMenuItem<String>(
                                      value: value.name,
                                      child: new Text(
                                        value.name,
                                        style: TextStyle(
                                            fontFamily: 'light',
                                            color: Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                  value: styleCodeCubit.state.styleChecks
                                      .where((element) => element.check)
                                      .toList()
                                      .where((element) =>
                                          element.name == state.value)
                                      .first
                                      .name,
                                  onChanged: (value) {
                                    singleDropDownItemCubit.changeItem(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultTextField(
                          // textInputType: TextInputType.number,
                          textEditingController: textEditingController,
                          hint: "سایز",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            cubit.add(SizesAndStyle(
                              key: cubit.state.list.isEmpty?0:cubit.state.list.last.key+1,
                                size: textEditingController.text
                                    .toString()
                                    .trim(),
                                style: singleDropDownItemCubit.state.value));
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "ثبت",
                            style: theme.textTheme.headline2,
                          ),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.green.withOpacity(0.4),
                            ),
                            backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.green.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(7),
          child: BackgroundWidget(
            height: 80,
            width: 80,
            child: Center(
              child: Text(
                MyIcons.PLUS,
                style: MyTextStyle.iconStyle,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: 'پروژه جدید',
              ),
              space(30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextField(
                  label: 'اسم برند',
                  textEditingController: brandController,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'مدل کار',
                        textEditingController: orderController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'تعداد',
                        textEditingController: rollController,
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              space(20),
              //style code
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => Directionality(
                              textDirection: TextDirection.ltr,
                              child: DialogBg(
                                child: Container(
                                  child: BlocBuilder(
                                    cubit: styleCodeCubit,
                                    builder: (BuildContext context,
                                            StyleCodeState state) =>
                                        ListView.builder(
                                      itemCount: styleCodes.length,
                                      itemBuilder: (BuildContext c, int i) {
                                        return CheckboxListTile(
                                          title: Text(styleCodes[i].name+'( '+styleCodes[i].shortName+' )',
                                              style: theme.textTheme.headline4),
                                          value: state.styleChecks[i].check,
                                          onChanged: (check) {
                                            styleCodeCubit.changeStyleCodeCheck(
                                                styleCodes[i].shortName, check);
                                          },
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  },
                  child: Text(
                    "کد استایل",
                    style: Theme.of(context).textTheme.headline2,
                  )),
              space(20),
              BlocBuilder(
                cubit: styleCodeCubit,
                builder: (BuildContext context, StyleCodeState state) {
                  String text = '';
                  state.styleChecks.forEach((element) {
                    if (element.check) {
                      text += element.name + ' ,';
                    }
                  });
                  if (text.isNotEmpty) {
                    text = text.substring(0, text.length - 1);
                  }
                  return Text(
                    text,
                    style: theme.textTheme.headline2,
                    textDirection: TextDirection.ltr,
                  );
                },
              ),
              space(20),
              BlocBuilder(
                cubit: cubit,
                builder: (BuildContext context, NewProjectSizeState state) =>
                    Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: List.generate(
                    state.list == null ? 1 : state.list.length + 1,
                    (index) => index == 0
                        ? addSize(cubit)
                        : GestureDetector(
                          onTap: (){
                            cubit.remove(state.list[index-1].key);
                          },
                          child: Container(
                              margin: EdgeInsets.all(7),
                              child: BackgroundWidget(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(state.list[index - 1].size),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(state.list[index - 1].style),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ),
                  ),
                ),
              ),
              space(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultTextField(
                  maxLine: 3,
                  textEditingController: descriptionController,
                  label: 'توضیحات',
                ),
              ),
              space(20),
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
                              if (orderController.text.isEmpty ||
                                  brandController.text.isEmpty) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا تمامی فیلدها را پر کنید.');
                              } else if (cubit.state.list == null) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا سایزها را وارد کنید.');
                              } else if (cubit.state.list.length == 0) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا سایزها را وارد کنید.');
                              } else {
                                String styleCode = '';
                                styleCodeCubit.state.styleChecks
                                    .forEach((element) {
                                  if (element.check) {
                                    styleCode += element.name + ',';
                                  }
                                });
                                if (styleCode.isEmpty) {
                                  MyShowSnackBar.showSnackBar(
                                      context, 'کد استایلی تعیین نشده است.');
                                } else {
                                  styleCode = styleCode.substring(
                                      0, styleCode.length - 1);
                                  String order = orderController.text;
                                  String brand = brandController.text;
                                  String roll = rollController.text;
                                  // String styleCode = styleCodeController.text;
                                  String description =
                                      descriptionController.text;
                                  String size = '';
                                  List<Map<String,String>> list = [];
                                  cubit.state.list.forEach((element) {
                                    String short = styleCodes.firstWhere((item) => element.style == item.name).shortName;
                                    Map<String,String> map = {'styleCode':element.style,'size':element.size,'shortCodeStyle':short};
                                    list.add(map);
                                  });
                                  size = jsonEncode(list);
                                  ignoreButtonCubit.update(true);
                                  String insertToProject =
                                      Insert.queryInsertInProject(order, brand,
                                          roll, styleCode, size, description);
                                  String insertToMessage =
                                      Insert.queryInsertMessageNewProject(
                                          brand);
                                  MyShowSnackBar.showSnackBar(
                                      context, 'لطفا کمی منتظر بمانید.');
                                  String result =
                                      await MyRequest.simple2QueryRequest(
                                    'general_manager/insertProject.php',
                                    insertToProject,
                                    insertToMessage,
                                  );
                                  try {
                                    int id = int.tryParse(result.trim());
                                    if (id != null) {
                                      ignoreButtonCubit.update(false);
                                      MyShowSnackBar.hideSnackBar(context);
                                      projects.insert(
                                          0,
                                          Project(
                                              id: id.toString(),
                                              description: description,
                                              brand: brand,
                                              roll: roll,
                                              type: order,
                                              size: size,
                                              styleCode: styleCode));
                                      refreshProvider.refresh();
                                      Navigator.of(context).pop();
                                    } else {
                                      ignoreButtonCubit.update(false);
                                      MyShowSnackBar.hideSnackBar(context);
                                      MyShowSnackBar.showSnackBar(context,
                                          "خطا در برقراری ازتباط با اینترنت لطفا مجددا تلاش کنید.");
                                    }
                                  } catch (e) {
                                    ignoreButtonCubit.update(false);
                                    MyShowSnackBar.hideSnackBar(context);
                                    MyShowSnackBar.showSnackBar(context,
                                        "خطا در برقراری ازتباط با اینترنت لطفا مجددا تلاش کنید.");
                                  }
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
              space(10)
            ],
          ),
        ),
      ),
    );
  }
}
