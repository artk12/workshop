import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/dialog_item_bloc.dart';
import 'package:workshop/module/stockpile/item_available_name.dart';
import 'package:workshop/stock/entry_to_stock/add_fabric_item.dart';
import 'package:workshop/stock/entry_to_stock/add_new_item.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_button.dart';

import 'entry_to_stock/add_available_item.dart';

class DialogItem extends StatelessWidget {

  final List<ItemNameAvailable>? availableItems;
  DialogItem({this.availableItems});

  @override
  Widget build(BuildContext context) {

    DialogItemCubit dialogItemCubit = new DialogItemCubit(DialogItemState());

    return Dialog(
      backgroundColor: Colors.transparent,
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
                        builder:(context,DialogItemState state)=> CustomDropdownButton<String>(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          items: availableItems!
                              .map((ItemNameAvailable value) {
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
                            dialogItemCubit.changeItem(value!);
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
                                builder: (context) => AddAvailableItem(),
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
    );
  }
}
