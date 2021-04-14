import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AddFabricItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController manufactureController = new TextEditingController();
    TextEditingController caliteController = new TextEditingController();
    TextEditingController metricController = new TextEditingController();
    TextEditingController colorController = new TextEditingController();
    TextEditingController piecesController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    IgnoreButtonCubit ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));

    ThemeData theme = Theme.of(context);
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
                    child: Text(
                      'پارچه',
                      style: MyTextStyle.disPlay1,
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
                          label: 'سازنده',
                          textEditingController: manufactureController,
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
                          label: 'کالیته',
                          textEditingController: caliteController,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'متراژ',
                        textEditingController: metricController,
                        textInputType: TextInputType.number,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextField(
                          label: 'رنگ',
                          textEditingController: colorController,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        label: 'تعداد تکه',
                        textEditingController: piecesController,
                        textInputType: TextInputType.number,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextField(
                          maxLine: 3,
                          label: 'توضیحات',
                          textEditingController: descriptionController,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
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
                              onPressed: () async {
                                String manufacture = manufactureController.text;
                                String calite = caliteController.text;
                                String metric = metricController.text;
                                String color = colorController.text;
                                String pieces = piecesController.text;
                                String description = descriptionController.text;

                                if (manufacture.isEmpty ||
                                    calite.isEmpty ||
                                    metric.isEmpty ||
                                    color.isEmpty ||
                                    pieces.isEmpty) {
                                  MyShowSnackBar.showSnackBar(context, "لطفا تمامی فیلدها را پر کنید.");
                                } else {
                                  MyShowSnackBar.showSnackBar(context, "کمی صبرکنید...");
                                  String insert = Insert.queryInsertFabricToStockpile(manufacture,calite,metric,color,pieces,description);
                                  String res = await MyRequest.simpleQueryRequest('stockpile/runQuery.php', insert);
                                  if(res.trim() == "OK"){
                                    ignoreButtonCubit.update(false);
                                    MyShowSnackBar.hideSnackBar(context);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0),
                            child: TextButton(
                                // color: Colors.red.withOpacity(0.4),
                                // icon: Icons.close,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red.withOpacity(0.4),),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(MyIcons.CANCEL,style: MyTextStyle.iconStyle.copyWith(fontSize: 30),),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ),
                        Expanded(child: Container(),flex: 1,),
                      ],
                    ),
                  ),
                ),
                space,
              ],
            ),
          ),
      ),
    );
  }
}
