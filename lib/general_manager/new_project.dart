import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/background_widget.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewProject extends StatelessWidget {
  final List<Project> projects;
  final RefreshProvider refreshProvider;
  NewProject({this.projects, this.refreshProvider});
  @override
  Widget build(BuildContext context) {
    TextEditingController orderController = new TextEditingController();
    TextEditingController brandController = new TextEditingController();
    TextEditingController rollController = new TextEditingController();
    TextEditingController styleCodeController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    Widget space(double height) => SizedBox(height: height);
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    NewProjectSizeCubit cubit = new NewProjectSizeCubit(NewProjectSizeState());

    Widget addSize(NewProjectSizeCubit cubit) => GestureDetector(
          onTap: () {
            cubit.add();
          },
          child: Container(
            margin: EdgeInsets.all(7),
            child: BackgroundWidget(
              height: 60,
              width: 45,
              child: Center(
                child: Text(
                  MyIcons.PLUS,
                  style: MyTextStyle.iconStyle,
                ),
              ),
            ),
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: 'پروژه جدید',
              ),
              space(30),
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
                        label: 'اسم برند',
                        textEditingController: brandController,
                      ),
                    ),
                  ),
                ],
              ),
              space(20),
              Row(
                children: [
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
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'کد استایل',
                        textEditingController: styleCodeController,
                      ),
                    ),
                  ),
                ],
              ),
              space(20),
              BlocBuilder(
                cubit: cubit,
                builder: (BuildContext context, NewProjectSizeState state) =>
                    Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: List.generate(
                      state.sizeWidgets == null
                          ? 1
                          : state.sizeWidgets.length + 1,
                      (index) => index == 0
                          ? addSize(cubit)
                          : state.sizeWidgets[index - 1].widget),
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
                                  brandController.text.isEmpty ||
                                  styleCodeController.text.isEmpty) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا تمامی فیلدها را پر کنید.');
                              } else if (cubit.state.sizeTexts == null) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا سایزها را وارد کنید.');
                              } else if (cubit.state.sizeTexts.length == 0) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا سایزها را وارد کنید.');
                              } else {
                                String order = orderController.text;
                                String brand = brandController.text;
                                String roll = rollController.text;
                                String styleCode = styleCodeController.text;
                                String description = descriptionController.text;
                                String size = '';
                                cubit.state.sizeTexts.forEach((element) {
                                  size +=
                                      element.textEditingController.text + ',';
                                });
                                ignoreButtonCubit.update(true);
                                size = size.substring(0, size.length - 1);
                                String insertToProject =
                                    Insert.queryInsertInProject(order, brand,
                                        roll, styleCode, size, description);
                                String insertToMessage =
                                    Insert.queryInsertMessageNewProject(brand);
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا کمی منتظر بمانید.');
                                String result =
                                    await MyRequest.simple2QueryRequest(
                                  'general_manager/insertProject.php',
                                  insertToProject,
                                  insertToMessage,
                                );
                                print(result);
                                try {
                                  int id = int.tryParse(result.trim());
                                  if (id != null) {
                                    ignoreButtonCubit.update(false);
                                    MyShowSnackBar.hideSnackBar(context);
                                    projects.add(Project(
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
