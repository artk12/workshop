import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workshop/bloc/general_manager/new_project_size_bloc.dart';
import 'package:workshop/cutter/calculate_cutter.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/background_widget.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'cutter_page.dart';

class PiecesLayer {
  final String layer;
  final String surplus;

  PiecesLayer({this.surplus, this.layer});

  factory PiecesLayer.fromJson(Map map) {
    return PiecesLayer(
      layer: map['layer'],
      surplus: map['surplus'],
    );
  }
}

class CutterDetailPage extends StatelessWidget {
  final Cut cutDetail;

  CutterDetailPage({this.cutDetail});

  @override
  Widget build(BuildContext context) {
    int pieces = int.parse(cutDetail.fabric.pieces);
    List<PiecesLayer> piecesList =
        CalculateCutter.getPiecesFromJson(cutDetail.pieces);
    Widget space(double height) => SizedBox(height: height);
    TextEditingController realUsage =
        new TextEditingController(text: cutDetail.realUsage);
    TextEditingController usage =
        new TextEditingController(text: cutDetail.usage);
    TextEditingController height =
        new TextEditingController(text: cutDetail.height);
    // TextEditingController cutCode =
    //     new TextEditingController(text: cutDetail.cutCode);
    TextEditingController totalGoods =
        new TextEditingController(text: cutDetail.totalGoods);
    TextEditingController description =
        new TextEditingController(text: cutDetail.description);

    final json =
        jsonDecode(cutDetail.project.size).cast<Map<String, dynamic>>();
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
        child: Text(text),
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
                readOnly: true,
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
                readOnly: true,
                textInputType: TextInputType.number,
              ))
            ],
          ),
        ],
      );
    }

    Widget itemDetail(String title1, String title2, String title3,
        String value1, String value2, String value3) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
                  textWithUnderLine(title3 + " : " + value3),
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
        TextEditingController quantify =
            new TextEditingController(text: piecesList[i - 1].layer);
        TextEditingController surplus =
            new TextEditingController(text: piecesList[i - 1].surplus);
        textEditingControllers
            .add(MyTextEditingController(quantify: quantify, surplus: surplus));
        tableRows.add(piecesWidget(i.toString(), quantify, surplus));
      }
    }

    return DialogBg(
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyAppbar(
              title: "برش پروژه " + "#" + cutDetail.project.id,
            ),
            space(20),
            Row(
              children: [
                Expanded(
                  child: itemDetail(
                    'سازنده',
                    'تکه',
                    'نوع کار',
                    cutDetail.fabric.manufacture,
                    cutDetail.fabric.pieces,
                    cutDetail.project.type,
                  ),
                ),
                Expanded(
                  child: itemDetail(
                    'متراژ',
                    'رنگ',
                    'کداستایل',
                    cutDetail.fabric.metric,
                    cutDetail.fabric.color,
                    cutDetail.project.styleCode,
                  ),
                ),
              ],
            ),
            space(30),
            textWithUnderLine("برش های این طاقه"),
            space(15),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Wrap(
                children: List.generate(
                  cutDetail.cutCode.length,
                  (index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(cutDetail.cutCode[index].cutCode),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            space(10),
            textWithUnderLine("سایزها"),
            space(10),
            Wrap(
              children: sizes,
            ),
            space(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWithUnderLine("توضیحات : " + "این توضیحات است."),
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
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: DefaultTextField(
                    label: "مصرف",
                    textInputType: TextInputType.number,
                    textEditingController: usage,
                    readOnly: true,
                  ),
                ),
                Expanded(
                  child: DefaultTextField(
                    label: "طول",
                    textInputType: TextInputType.number,
                    textEditingController: height,
                    readOnly: true,
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
                        tableRows.length, (index) => tableRows[index]),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                // Expanded(
                //   child: DefaultTextField(
                //       label: "کد برش",
                //       textInputType: TextInputType.number,
                //       readOnly: true,
                //       textEditingController: cutCode),
                // ),
                Expanded(
                  child: DefaultTextField(
                    label: "جمع کل کار",
                    textInputType: TextInputType.number,
                    readOnly: true,
                    textEditingController: totalGoods,
                  ),
                ),
              ],
            ),
            space(20),
            DefaultTextField(
                maxLine: 2,
                readOnly: true,
                label: "توضیحات",
                textEditingController: description),
            space(20),
          ],
        ),
      ),
    );
  }
}
