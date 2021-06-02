import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/cutter/calculate_cutter.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/cutter/cut_detail.dart';
import 'package:workshop/module/general_manager/project.dart';
import 'package:workshop/module/general_manager/styleCode.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

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

  CutterPage({this.cutDetail,this.styleCodes});

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
    TextEditingController cutCode = new TextEditingController();
    TextEditingController totalGoods = new TextEditingController();
    TextEditingController description = new TextEditingController();
    String cutCodeStyle = '';
    styleCodes.forEach((element) {
      if(cutDetail.styleCode.contains(element.name)){
        cutCodeStyle += element.shortName+'/';
      }
    });
    cutCodeStyle = cutCodeStyle.substring(0,cutCodeStyle.length-1);
    String des = cutDetail.projectDescription.isEmpty
        ? "ندارد"
        : cutDetail.projectDescription;

    Widget textWithUnderLine(String text) {
      return Container(
        child: Text(
          text,
          style: theme.textTheme.headline4,
        ),
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.white, width: 1),
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
      String pieces = CalculateCutter.getPiecesJson(textEditingControllers);
      String insert = Insert.queryInsertCutterProject(
          cutDetail.projectId,
          cutDetail.fabricId,
          realUsage.text,
          usage.text,
          height.text,
          pieces,
          totalGoods.text,
          cutCode.text,
          description.text);
      String result =
          await MyRequest.simpleQueryRequest('stockpile/runQuery.php', insert);
      ignoreButtonCubit.update(false);
      if (result.trim() == "OK") {
        MyShowSnackBar.hideSnackBar(context);
        DateTime dateTime = DateTime.now();
        int year = dateTime.year;
        int month = dateTime.month;
        int day = dateTime.day;
        CutReturn cutReturn = CutReturn(
            repeat: check,
            cut: Cut(
              description: description.text.toString(),
              height: height.text.toString(),
              id: '0',
              cutCode: cutCode.text.toString(),
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
                  manufacture: cutDetail.manufacture),
            ));
        Navigator.pop(context, cutReturn);
      } else {
        MyShowSnackBar.showSnackBar(context, 'کمی صبر کنید...');
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: "برش برای پروژه " + "#" + cutDetail.projectId,
                leftWidget: [
                  MyIconButton(
                    icon: MyIcons.CANCEL,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWithUnderLine("سایز : " + cutDetail.size),
                ],
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
                      label: "مصرف واقعی",
                      textEditingController: realUsage,
                      textInputType: TextInputType.number,
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
                    child: DefaultTextField(
                        label: "کد برش",
                        textInputType: TextInputType.number,
                        textEditingController: cutCode),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      label: "جمع کل کار",
                      textInputType: TextInputType.number,
                      textEditingController: totalGoods,
                    ),
                  ),
                ],
              ),
              space(20),
              DefaultTextField(
                  maxLine: 2,
                  label: "توضیحات",
                  textEditingController: description),
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
                              bool check = CalculateCutter.checkPiecesField(
                                  textEditingControllers);
                              if (!check) {
                                MyShowSnackBar.showSnackBar(context,
                                    'لطفا تمامی فیلدهای برش تکه را پر کنید.');
                              } else if (realUsage.text.isEmpty ||
                                  usage.text.isEmpty ||
                                  height.text.isEmpty ||
                                  cutCode.text.isEmpty ||
                                  totalGoods.text.isEmpty) {
                                MyShowSnackBar.showSnackBar(
                                    context, 'لطفا تمامی فیلدهای را پر کنید.');
                              } else {
                                insert();
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue.withOpacity(0.4),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            MyIcons.PLUS,
                            style: MyTextStyle.iconStyle.copyWith(fontSize: 30),
                          ),
                        ),
                        onPressed: () {
                          insert(check: true);
                        },
                      ),
                      SizedBox(
                        height: 10,
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
              space(20),
            ],
          ),
        ),
      ),
    );
  }
}
