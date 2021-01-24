import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/stock/import_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/import_to_stock/add_new_item.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'import_to_stock/update_item.dart';

class DialogItem extends StatelessWidget {

  final List<Item> item;
  DialogItem({this.item});

  @override
  Widget build(BuildContext context) {

    SingleDropDownItemCubit dialogItemCubit = new SingleDropDownItemCubit(SingleDropDownItemState(value: item[0].id));

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white30,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'اضافه کالا جدید',
                    style: TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'bold',
                        color: Colors.white),
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
                          builder:(context,SingleDropDownItemState state)=> CustomDropdownButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            items: item
                                .map((Item value) {
                              return new CustomDropdownMenuItem<String>(
                                value: value.id,
                                child: new Text(
                                  value.name,
                                  style: TextStyle(
                                      fontFamily: 'light', color: Colors.white),
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
                                  builder: (context) => UpdateItem(item: item.where((element) => element.id == dialogItemCubit.state.value).first,),
                                  settings:
                                      RouteSettings(name: '/addAvailableItem')));
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
            ),
          ),
        ),
      ),
    );
  }
}
