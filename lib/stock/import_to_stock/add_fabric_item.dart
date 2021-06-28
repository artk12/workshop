import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';
import 'package:workshop/time_format.dart';

class AddFabricItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController manufactureController = new TextEditingController();
    TextEditingController caliteController = new TextEditingController();
    TextEditingController metricController = new TextEditingController();
    TextEditingController colorController = new TextEditingController();
    TextEditingController piecesController = new TextEditingController();
    TextEditingController descriptionController = new TextEditingController();
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    DialogMessageCubit messageCubit =
        new DialogMessageCubit(DialogMessageState(message: ""));

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
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white12)),
                onPressed: () {
                  String barcode = TimeFormat.generateBarcode();
                  messageCubit.changeMessage(barcode);
                },
                child: Text(
                  "بارکد",
                  style: theme.textTheme.headline2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder(
                cubit: messageCubit,
                builder: (BuildContext context, DialogMessageState state) =>
                    Text(
                  state.message,
                  style: theme.textTheme.headline1.copyWith(fontSize:28),
                ),
              ),
              SizedBox(
                height: 10,
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
                builder: (BuildContext context, IgnoreButtonState state) =>
                    IgnorePointer(
                  ignoring: state.ignore,
                  child:SaveAndCancelButton(
                    cancelButton: (){Navigator.of(context).pop();},
                    saveButton: () async {
                      String manufacture = manufactureController.text;
                      String calite = caliteController.text;
                      String metric = metricController.text;
                      String color = colorController.text;
                      String pieces = piecesController.text;
                      String description = descriptionController.text;
                      String barcode = messageCubit.state.message;

                      if (manufacture.isEmpty ||
                          // calite.isEmpty ||
                          metric.isEmpty ||
                          // color.isEmpty ||
                          pieces.isEmpty) {
                        MyShowSnackBar.showSnackBar(
                            context, "لطفا تمامی فیلدها را پر کنید.");
                      } else if (barcode.trim().isEmpty) {
                        MyShowSnackBar.showSnackBar(
                            context, "بارکد تعیین نشده است.");
                      } else {
                        MyShowSnackBar.showSnackBar(
                            context, "کمی صبرکنید...");
                        String insert =
                        Insert.queryInsertFabricToStockpile(
                            manufacture,
                            calite,
                            metric,
                            color,
                            pieces,
                            barcode,
                            description);
                        String res = await MyRequest.simpleQueryRequest(
                            'stockpile/runQuery.php', insert);
                        if (res.trim() == "OK") {
                          ignoreButtonCubit.update(false);
                          MyShowSnackBar.hideSnackBar(context);
                          Navigator.pop(context);
                        }
                      }
                    },
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
