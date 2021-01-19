import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/export_from_stock_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/icon_outline_button.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class ExportFromStock extends StatelessWidget {
  // final List<ItemName>? itemNamesAvailable;
  final List<Item>? items;
  final List<Fabric>? fabrics;
  ExportFromStock({this.items, this.fabrics});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    ExportFromStockPileCubit exportFromStockPileCubit =
        new ExportFromStockPileCubit(
            ExportFromStockPileState(items: [], item: null));
    SingleDropDownItemCubit categoryCubit =
        new SingleDropDownItemCubit(SingleDropDownItemState(value: null));
    SingleDropDownItemCubit itemCubit =
        new SingleDropDownItemCubit(SingleDropDownItemState(value: null));

    List<String> nameCategory = ['خرج کار', 'بسته بندی', 'پارچه'];
    Widget space(double height) => SizedBox(height: height);

    TextEditingController person = new TextEditingController();
    TextEditingController description = new TextEditingController();
    TextEditingController amount = new TextEditingController();

    return Scaffold(
      body: StockBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StockAppbar(
                title: 'خروج از انبار',
              ),
              space(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: categoryCubit,
                            builder: (BuildContext context,
                                    SingleDropDownItemState state) =>
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
                              value: state.value,
                              onChanged: (value) {
                                categoryCubit.changeItem(value!);
                                if (value == 'پارچه') {
                                  exportFromStockPileCubit
                                      .changeToFabric('fabric');
                                  exportFromStockPileCubit.updateFabric(null);
                                  itemCubit.changeItem(null);
                                } else {
                                  exportFromStockPileCubit
                                      .changeToFabric('item');
                                  itemCubit.changeItem(null);
                                  exportFromStockPileCubit.changeItem(null);
                                  exportFromStockPileCubit.updateItems(
                                    items!
                                        .where((element) =>
                                            element.category == value)
                                        .toList(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: exportFromStockPileCubit,
                            builder: (BuildContext context,
                                    ExportFromStockPileState itemState) =>
                                BlocBuilder(
                              cubit: itemCubit,
                              builder: (BuildContext context,
                                      SingleDropDownItemState state) => CustomDropdownButton<String>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                mainAxisAlignment: MainAxisAlignment.start,
                                items: itemState.itemSelected == 'fabric'
                                    ? fabrics!.map((fabric) {
                                        return CustomDropdownMenuItem<String>(
                                          value: fabric.id,
                                          child: new Text(
                                            fabric.calite!,
                                            style: TextStyle(
                                                fontFamily: 'light',
                                                color: Colors.white),
                                          ),
                                        );
                                      }).toList()
                                    : itemState.items!
                                        .map((Item value) {
                                        return CustomDropdownMenuItem<String>(
                                          value: value.id,
                                          child: new Text(
                                            value.name!,
                                            style: TextStyle(
                                                fontFamily: 'light',
                                                color: Colors.white),
                                          ),
                                        );
                                      }).toList(),
                                value: state.value,
                                onChanged: (value) {
                                  itemCubit.changeItem(value!);
                                  if (itemState.itemSelected == 'fabric') {
                                    Fabric myFabric = fabrics!
                                        .where((element) => element.id == value)
                                        .first;
                                    exportFromStockPileCubit
                                        .updateFabric(myFabric);
                                  } else {
                                    Item myItem = items!
                                        .where((element) =>
                                            element.id == value)
                                        .first;
                                    exportFromStockPileCubit.changeItem(myItem);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              space(10),
              BlocBuilder(
                cubit: exportFromStockPileCubit,
                builder: (BuildContext context,
                        ExportFromStockPileState state) =>
                    state.itemSelected == 'fabric'
                        ? Container()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 7),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'موجودی : ',
                                          style: theme.textTheme.headline1!
                                              .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 25,
                                                  shadows: [
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 6)
                                              ]),
                                        ),
                                        //item
                                        BlocBuilder(
                                          cubit: exportFromStockPileCubit,
                                          builder: (BuildContext context,
                                                  ExportFromStockPileState
                                                      state) =>
                                              Text(
                                            state.item == null
                                                ? '0'
                                                : state.item!.quantifierOne!,
                                            style: theme.textTheme.headline1!
                                                .copyWith(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 25,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 6)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              space(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DefaultTextField(
                                        label: 'مقدار',
                                        textEditingController: amount,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(bottom: 7),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            child: BlocBuilder(
                                              cubit: exportFromStockPileCubit,
                                              builder: (BuildContext context,
                                                      ExportFromStockPileState
                                                          state) =>
                                                  Text(
                                                state.item == null
                                                    ? ' انتخاب نشده '
                                                    : state.item!.quantify!,
                                                style: theme
                                                    .textTheme.headline1!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 25,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 6)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
              ),
              space(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultTextField(
                  textEditingController: person,
                  label: 'تحویل به',
                ),
              ),
              space(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DefaultTextField(
                  maxLine: 3,
                  textEditingController: description,
                  label: 'توضیحات',
                ),
              ),
              space(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconOutlineButton(
                    color: Colors.green.withOpacity(0.4),
                    icon: Icons.check,
                    onPressed: () async {
                      DateTime dateTime = DateTime.now();
                      if (exportFromStockPileCubit.state.itemSelected == 'item') {
                        if (exportFromStockPileCubit.state.item == null) {
                          MyShowSnackBar.showSnackBar(
                              context, 'کالایی انتخاب نشده است.');
                        } else {
                          int inventory = int.parse(exportFromStockPileCubit
                              .state.item!.quantifierOne!);
                          int amountInt = int.parse(amount.text);
                          if (amountInt > inventory) {
                            MyShowSnackBar.showSnackBar(context,
                                'مقدار ورودی شما بیشتر از موجودی انبار است.');
                          } else {
                            String insert = Insert.queryInsertOutputToLog(
                                amount.text,
                                dateTime.year,
                                dateTime.month,
                                dateTime.day,
                                person.text,
                                description.text);
                            String update = Update.queryUpdateStockQuantifier(
                                exportFromStockPileCubit.state.item!.id!,
                                amount.text);
                            await MyRequest.simple2QueryRequest(
                                'stockpile/run2Query.php', insert, update);
                          }
                        }
                      } else {
                        if(exportFromStockPileCubit.state.fabric == null){
                          MyShowSnackBar.showSnackBar(context, 'کالیته ای انتخاب نشده است.');
                        }else{
                          Fabric fabric = exportFromStockPileCubit.state.fabric!;
                          String insert = Insert.queryInsertToFabricLog(fabric.id!, '0', description.text, dateTime.year, dateTime.month, dateTime.day, person.text);
                          String update = Update.queryUpdateLogInFabricTable(fabric.id!, '0');
                          await MyRequest.simple2QueryRequest(
                              'stockpile/run2Query.php', insert, update);
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
            ],
          ),
        ),
      ),
    );
  }
}
