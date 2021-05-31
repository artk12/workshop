
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/stock/import_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/import_to_stock/add_new_item.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'update_item.dart';

class ImportItemDialog extends StatelessWidget {
  final List<Item> item;
  ImportItemDialog({this.item});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    SingleDropDownItemCubit dialogItemCubit =
        item.length == 0 ? new SingleDropDownItemCubit(SingleDropDownItemState(value: "")):new SingleDropDownItemCubit(SingleDropDownItemState(value: item[0].id));
    // SingleDropDownItemCubit dialogItemCubit

    return DialogBg(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'اضافه کالا جدید',
            style: theme.textTheme.headline2
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 100,
                child: BlocBuilder(
                  cubit: dialogItemCubit,
                  builder: (context, SingleDropDownItemState state) =>
                      CustomDropdownButton<String>(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    items: item.map((Item value) {
                      return new CustomDropdownMenuItem<String>(
                        value: value.id,
                        child: new Text(
                          value.name,
                          style: theme.textTheme.headline6,
                        ),
                      );
                    }).toList(),
                    value: state.value,
                    onChanged: (value) {
                      dialogItemCubit.changeItem(value);
                    },
                  ),
                ),
              ),
              DefaultButton(
                title: 'اعمال',
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateItem(
                                item: item
                                    .where((element) =>
                                        element.id ==
                                        dialogItemCubit.state.value)
                                    .first,
                              ),
                          settings: RouteSettings(name: '/addAvailableItem')));
                },
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          DefaultButton(
            title: 'اضافه پارچه جدید',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddFabricItem(),
                      settings: RouteSettings(name: '/addFabric')));
            },
          ),
          SizedBox(
            height: 10,
          ),
          DefaultButton(
            title: 'اضافه آیتم جدید',
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewItem(),
                      settings: RouteSettings(name: '/addNewItem')));
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
