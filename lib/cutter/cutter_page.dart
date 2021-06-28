import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/cutter/calculate_cutter.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/cutter/cut_detail.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/general_manager/styleCode.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/background_widget.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class MyTextEditingController {
  final TextEditingController quantify;
  final TextEditingController surplus;

  MyTextEditingController({this.quantify, this.surplus});
}

class CutReturn {
  Cut cut;
  bool repeat;

  CutReturn({this.cut, this.repeat});
}

class CutterPage extends StatelessWidget {
  final CutDetail cutDetail;
  final List<StyleCode> styleCodes;
  final String barCode;

  CutterPage({this.cutDetail, this.styleCodes, this.barCode});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    int pieces = int.parse(cutDetail.pieces);
    Widget space(double height) => SizedBox(height: height);
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    TextEditingController realUsage = new TextEditingController();
    TextEditingController usage = new TextEditingController();
    TextEditingController height = new TextEditingController();
    TextEditingController totalGoods = new TextEditingController();
    TextEditingController description = new TextEditingController();
    DialogMessageCubit dialogMessageCubit = DialogMessageCubit(DialogMessageState(message: ''));


    String style = cutDetail.styleCode + ',';
    List<String> styleCodeList = [];
    List<String> styleCodeShortList = [];

    while (style.isNotEmpty) {
      String s = style.substring(0, style.indexOf(','));
      styleCodeList.add(s);
      try {
        String short =
            styleCodes.firstWhere((element) => element.name == s).shortName;
        styleCodeShortList.add(short);
      } catch (e) {}
      style = style.substring(s.length + 1);
    }
    String des = cutDetail.projectDescription.isEmpty
        ? "ندارد"
        : cutDetail.projectDescription;

    final json = jsonDecode(cutDetail.size).cast<Map<String, dynamic>>();
    List<SizesAndStyle> list = json
        .map<SizesAndStyle>((json) => SizesAndStyle.fromJson(json))
        .toList();
    List<Widget> sizes = [];
    list.forEach((element) {
      sizes.add(Container(
        margin: EdgeInsets.all(7),
        child: BackgroundWidget(
          height: 80,
          width: 80,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(element.size),
                SizedBox(
                  height: 5,
                ),
                Text(element.style),
              ],
            ),
          ),
        ),
      ));
    });

    Widget textWithUnderLine(String text) {
      return Container(
        child: Text(
          text,
          style: theme.textTheme.headline4,
        ),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black, width: 1),
          ),
        ),
      );
    }

    TableRow head() {
      return TableRow(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text('تکه'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text('لایه'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Center(child: Text('باقیمانده')),
            ),
          ],
        ),
      ]);
    }

    TableRow piecesWidget(String count, TextEditingController quantify,
        TextEditingController surplus) {
      return TableRow(
        children: [
          Column(
            children: [
              Container(
                height: 80,
                child: Center(child: Text(count)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: DefaultTextField(
                hint: "تعداد",
                textInputType: TextInputType.number,
                textEditingController: quantify,
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: DefaultTextField(
                hint: "مقدار اضافه",
                textEditingController: surplus,
                textInputType: TextInputType.number,
              ))
            ],
          ),
        ],
      );
    }

    Widget itemDetail(String title1, String title2, String title3,
        String value1, String value2, String value3,
        {check = false}) {
      List<String> styleCodes = [];
      SingleDropDownItemCubit styleCodeCubit;
      if (check) {
        if (value3[value3.length - 1] != ",") {
          value3 = value3 + ',';
        }
        String total = value3;
        while (total.isNotEmpty) {
          String res = total.substring(0, total.indexOf(',') + 1);
          total = total.replaceFirst(res, '');
          styleCodes.add(res.replaceFirst(',', ''));
        }
        styleCodeCubit = new SingleDropDownItemCubit(
            SingleDropDownItemState(value: styleCodes[0]));
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWithUnderLine(title1 + " : " + value1),
                  space(15),
                  textWithUnderLine(title2 + " : " + value2),
                  space(15),
                  !check
                      ? textWithUnderLine(title3 + " : " + value3)
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: 84,
                          child: DropDownBackground(
                            child: CustomDropdownButtonHideUnderline(
                              child: BlocBuilder(
                                cubit: styleCodeCubit,
                                builder: (BuildContext context,
                                        SingleDropDownItemState state) =>
                                    CustomDropdownButton<String>(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  items: styleCodes.map((String value) {
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
                                  value: state.value,
                                  onChanged: (value) {
                                    styleCodeCubit.changeItem(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    List<TableRow> tableRows = [];
    List<MyTextEditingController> textEditingControllers = [];
    for (int i = 0; i < pieces + 1; i++) {
      if (i == 0) {
        tableRows.add(head());
      } else {
        TextEditingController quantify = new TextEditingController();
        TextEditingController surplus = new TextEditingController();
        textEditingControllers
            .add(MyTextEditingController(quantify: quantify, surplus: surplus));
        tableRows.add(piecesWidget(i.toString(), quantify, surplus));
      }
    }

    void insert({bool check = false}) async {
      ignoreButtonCubit.update(true);
      MyShowSnackBar.showSnackBar(context, 'کمی صبر کنید...');
      List<CutCode> cutCodesList = CalculateCutter.getCutCodeList(
          textEditingControllers,
          styleCodeShortList,
          cutDetail.projectId,
          (int.parse(cutDetail.rollComplete) + 1).toString());
      String cutCodesJson = CalculateCutter.getCutCodeListJson(
          textEditingControllers,
          styleCodeShortList,
          cutDetail.projectId,
          (int.parse(cutDetail.rollComplete) + 1).toString());
      String pieces = CalculateCutter.getPiecesJson(
          textEditingControllers,
          styleCodeShortList,
          cutDetail.projectId,
          (int.parse(cutDetail.rollComplete) + 1).toString());
      String insert = Insert.queryInsertCutterProject(
          cutDetail.projectId,
          cutDetail.fabricId,
          realUsage.text,
          usage.text,
          height.text,
          pieces,
          totalGoods.text,
          cutCodesJson,
          description.text);
      String update = Update.updateCutterCounter(
          int.parse(cutDetail.rollComplete) + 1, cutDetail.projectId);
      String result = await MyRequest.insertCutRequest(
          insert, update, pieces, cutDetail.fabricId);

      ignoreButtonCubit.update(false);

      if (result.trim().contains("OK")) {
        MyShowSnackBar.hideSnackBar(context);
        DateTime dateTime = DateTime.now();
        int year = dateTime.year;
        int month = dateTime.month;
        int day = dateTime.day;
        Cut cut = Cut(
          description: description.text.toString(),
          height: height.text.toString(),
          id: '0',
          cutCode: cutCodesList,
          pieces: pieces,
          realUsage: realUsage.text.toString(),
          usage: usage.text.toString(),
          totalGoods: totalGoods.text.toString(),
          day: day.toString(),
          month: month.toString(),
          year: year.toString(),
          project: Project(
            id: cutDetail.projectId,
            styleCode: cutDetail.styleCode,
            size: cutDetail.size,
            type: cutDetail.type,
            roll: cutDetail.roll,
            description: cutDetail.projectDescription,
            brand: cutDetail.brand,
          ),
          fabric: Fabric(
              id: cutDetail.fabricId,
              description: cutDetail.fabricDescription,
              color: cutDetail.color,
              pieces: cutDetail.pieces,
              metric: cutDetail.metric,
              calite: cutDetail.calite,
              barCode: barCode,
              manufacture: cutDetail.manufacture),
        );
        CutReturn cutReturn = CutReturn(repeat: check, cut: cut);
        Navigator.pop(context, cutReturn);
      } else {
        MyShowSnackBar.showSnackBar(context, 'خطا در برقراری ارتباط..');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: "برش برای پروژه " + "#" + cutDetail.projectId,
              ),
              space(20),
              Row(
                children: [
                  Expanded(
                    child: itemDetail(
                        'سازنده',
                        'تکه',
                        'نوع کار',
                        cutDetail.manufacture,
                        cutDetail.pieces,
                        cutDetail.type),
                  ),
                  Expanded(
                    child: itemDetail('متراژ', 'رنگ', 'کداستایل',
                        cutDetail.metric, cutDetail.color, cutDetail.styleCode,
                        check: false),
                  ),
                ],
              ),
              space(30),
              Wrap(
                children: sizes,
              ),
              space(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWithUnderLine("توضیحات : " + des),
                ],
              ),
              space(20),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextField(
                      label: "جمع کل کار",
                      textInputType: TextInputType.number,
                      textEditingController: totalGoods,
                      onChange: (String s){
                        int x = int.parse(s);
                        int metric = int.parse(cutDetail.metric);
                        // dialogMessageCubit.changeMessage(((metric*100)/x).toString());
                        // realUsage.text = new TextEditingController(text: .);
                        realUsage.text = ((metric*100)/x).round().toString();
                      },
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      label: "مصرف",
                      textInputType: TextInputType.number,
                      textEditingController: usage,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      label: "طول",
                      textInputType: TextInputType.number,
                      textEditingController: height,
                    ),
                  ),
                ],
              ),
              space(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                  child: Center(
                    child: Table(
                        border: TableBorder.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        columnWidths: {
                          0: IntrinsicColumnWidth(flex: 1),
                          1: IntrinsicColumnWidth(flex: 2),
                          2: IntrinsicColumnWidth(flex: 2),
                        },
                        children: List.generate(
                            tableRows.length, (index) => tableRows[index])),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder(
                      cubit: dialogMessageCubit,
                      builder:(BuildContext c , DialogMessageState s)=> DefaultTextField(
                        label: "مصرف واقعی",
                        textEditingController: realUsage,
                        // initText: s.message,
                        textInputType: TextInputType.number,
                        readOnly: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
              space(20),
              DefaultTextField(
                  maxLine: 2,
                  label: "توضیحات",
                  textEditingController: description),
              space(10),
              Text("طاقه : " +
                  (int.parse(cutDetail.rollComplete) + 1).toString() +
                  " از " +
                  cutDetail.roll),
              space(20),
              BlocBuilder(
                cubit: ignoreButtonCubit,
                builder: (BuildContext context, IgnoreButtonState state) =>
                    IgnorePointer(
                  ignoring: state.ignore,
                  child: SaveAndCancelButton(
                    cancelButton: (){Navigator.of(context).pop();},
                    saveButton: () async {
                      bool check = CalculateCutter.checkPiecesField(
                          textEditingControllers);
                      if (!check) {
                        MyShowSnackBar.showSnackBar(context,
                            'لطفا تمامی فیلدهای برش تکه را پر کنید.');
                      } else if (realUsage.text.isEmpty ||
                          usage.text.isEmpty ||
                          height.text.isEmpty ||
                          totalGoods.text.isEmpty) {
                        MyShowSnackBar.showSnackBar(
                            context, 'لطفا تمامی فیلدهای را پر کنید.');
                      } else {
                        bool check = int.parse(cutDetail.roll) ==
                            (int.parse(cutDetail.rollComplete) + 1)
                            ? false
                            : true;
                        insert(check: check);
                      }
                    },
                  ),
                ),
              ),
              space(20),
            ],
          ),
        ),
      ),
    );
  }
}
