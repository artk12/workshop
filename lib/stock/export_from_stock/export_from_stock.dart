import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/export_from_stock_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/show_snackbar.dart';
import 'package:workshop/style/theme/textstyle.dart';

class ExportFromStock extends StatelessWidget {
  final List<Item> items;
  final List<Fabric> fabrics;
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
    IgnoreButtonCubit ignoreButtonCubit = IgnoreButtonCubit(IgnoreButtonState(ignore: false));

    TextEditingController person = new TextEditingController();
    TextEditingController description = new TextEditingController();
    TextEditingController amount = new TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              MyAppbar(
                title: 'خروج از انبار',
              ),
              space(20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: DropDownBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: categoryCubit,
                            builder: (BuildContext context,
                                    SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
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
                                categoryCubit.changeItem(value);
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
                                    items
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
                      child: DropDownBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: exportFromStockPileCubit,
                            builder: (BuildContext context,
                                    ExportFromStockPileState itemState) =>
                                BlocBuilder(
                              cubit: itemCubit,
                              builder: (BuildContext context,
                                      SingleDropDownItemState state) => CustomDropdownButton<String>(
                                mainAxisAlignment: MainAxisAlignment.start,
                                items: itemState.itemSelected == 'fabric'
                                    ? fabrics.map((fabric) {
                                        return CustomDropdownMenuItem<String>(
                                          value: fabric.id,
                                          child: new Text(
                                            fabric.calite,
                                            style: theme.textTheme.headline6,
                                          ),
                                        );
                                      }).toList()
                                    : itemState.items
                                        .map((Item value) {
                                        return CustomDropdownMenuItem<String>(
                                          value: value.id,
                                          child: new Text(
                                            value.name,
                                            style: theme.textTheme.headline6,
                                          ),
                                        );
                                      }).toList(),
                                value: state.value,
                                onChanged: (value) {
                                  itemCubit.changeItem(value);
                                  if (itemState.itemSelected == 'fabric') {
                                    Fabric myFabric = fabrics
                                        .where((element) => element.id == value)
                                        .first;
                                    exportFromStockPileCubit
                                        .updateFabric(myFabric);
                                  } else {
                                    Item myItem = items
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
                                          style: MyTextStyle.display2
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
                                                : state.item.quantifierOne,
                                            style: MyTextStyle.display2
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
                                        textInputType: TextInputType.number,
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
                                                    : state.item.quantify,
                                                style: MyTextStyle.display2
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
                              if (exportFromStockPileCubit.state.itemSelected == 'item') {
                                if (exportFromStockPileCubit.state.item == null) {
                                  MyShowSnackBar.showSnackBar(
                                      context, 'کالایی انتخاب نشده است.');
                                } else {
                                  int inventory = int.parse(exportFromStockPileCubit
                                      .state.item.quantifierOne);
                                  int amountInt = int.parse(amount.text);
                                  if (amountInt > inventory) {
                                    MyShowSnackBar.showSnackBar(context,
                                        'مقدار ورودی شما بیشتر از موجودی انبار است.');
                                  } else {
                                    ignoreButtonCubit.update(true);
                                    MyShowSnackBar.showSnackBar(context, "کمی صبرکنید...");
                                    String insert = Insert.queryInsertOutputToLog( exportFromStockPileCubit
                                        .state.item.id,amount.text,person.text, description.text);
                                    String update = Update.queryUpdateStockQuantifier(
                                        exportFromStockPileCubit.state.item.id,
                                        (inventory - amountInt).toString());
                                    String body = await MyRequest.simple2QueryRequest(
                                        'stockpile/run2Query.php', insert, update);
                                    if(body == "OK"){
                                      ignoreButtonCubit.update(false);
                                      MyShowSnackBar.hideSnackBar(context);
                                      Navigator.pop(context);
                                    }
                                  }
                                }
                              } else {
                                if(exportFromStockPileCubit.state.fabric == null){
                                  MyShowSnackBar.showSnackBar(context, 'کالیته ای انتخاب نشده است.');
                                }else{
                                  MyShowSnackBar.showSnackBar(context, "کمی صبرکنید...");
                                  ignoreButtonCubit.update(true);
                                  Fabric fabric = exportFromStockPileCubit.state.fabric;
                                  String insert = Insert.queryExportToFabricLog(fabric.id, description.text, person.text);
                                  String update = Update.queryUpdateLogInFabricTable(fabric.id, '0');
                                  String body = await MyRequest.simple2QueryRequest(
                                      'stockpile/run2Query.php', insert, update);
                                  if(body == "OK"){
                                    ignoreButtonCubit.update(false);
                                    MyShowSnackBar.hideSnackBar(context);
                                    Navigator.pop(context);
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
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.red.withOpacity(0.4),),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(MyIcons.CANCEL,style: MyTextStyle.iconStyle.copyWith(fontSize: 30),),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Expanded(child: Container(),flex: 1,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
