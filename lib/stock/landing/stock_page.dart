import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/bloc/stockpile/stock_category_bloc.dart';
import 'package:workshop/module/stockpile/all_items.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/stock/calculate_stock.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/icon_outline_button.dart';
import 'package:workshop/style/component/stockpile/fabricCardMobile.dart';
import 'package:workshop/style/component/stockpile/fabricCardTablet.dart';
import 'package:workshop/style/component/stockpile/itemCardMobile.dart';
import 'package:workshop/style/component/stockpile/itemCardTablet.dart';
import 'package:workshop/style/device_detector.dart';

class StockPage extends StatelessWidget {
  final List<ItemLog> itemLogs;
  final List<FabricLog> fabricLogs;
  final List<Fabric> fabrics;
  final List<Item> items;

  StockPage({this.items, this.fabrics, this.fabricLogs, this.itemLogs});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<AllItem> allItems = CalculateStock.mergeFabricAndItem(items, fabrics);
    CalculateStock.sortAllItem(allItems);
    List<Widget> myList = [];
    String device = DeviceDetector.deviceDetector();
    SingleDropDownItemCubit categoryCubit =
        new SingleDropDownItemCubit(SingleDropDownItemState(value: 'همه'));
    StockCategoryCubit stockCategoryCubit = new StockCategoryCubit(
        StockCategoryState(allItem: allItems, myList: myList));
    List<String> category = ['همه', 'خرج کار', 'بسته بندی', 'پارچه'];
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 30) / 2;
    final double itemWidth = size.width / 2;

    void onChange(String value) {
      stockCategoryCubit.search(allItems, value, device);
    }

    allItems.forEach((element) {
      if (element.category == "fabric") {
        if (device == 'phone') {
          myList.add(FabricCardMobile(
            fabric: element.fabric,
          ));
        } else {
          myList.add(FabricCardTablet(
            fabric: element.fabric,
          ));
        }
      } else {
        if (device == 'phone') {
          myList.add(ItemCardMobile(
            item: element.item,
          ));
        } else {
          myList.add(ItemCardTablet(
            item: element.item,
          ));
        }
      }
    });

    return StockBackground(
      child: Column(
        children: [
          BlurBackground(
            padding: EdgeInsets.zero,
            radius: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      height: 70,
                      child: TextField(
                        style: theme.textTheme.bodyText1,
                        onChanged: onChange,
                        decoration: InputDecoration(
                          hintText: 'جستجو...',
                          hintStyle: theme.textTheme.bodyText1
                              .copyWith(color: Colors.white.withOpacity(0.5)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.2),
                                width: 2.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 2.5),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    height: 40,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff3b4354),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: BlocBuilder(
                        cubit: categoryCubit,
                        builder: (context, SingleDropDownItemState state) =>
                            Theme(
                          data: theme.copyWith(canvasColor: Color(0xff4d5566)),
                          child: CustomDropdownButtonHideUnderline(
                            child: CustomDropdownButton<String>(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              mainAxisAlignment: MainAxisAlignment.start,
                              items: category.map((String value) {
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
                              value: category
                                  .where((element) => element == state.value)
                                  .first,
                              onChanged: (value) {
                                categoryCubit.changeItem(value);
                                if (value == "همه") {
                                  stockCategoryCubit.noFilter(allItems, device);
                                } else {
                                  if (value == "پارچه") {
                                    stockCategoryCubit.categoryFilter(
                                        allItems, 'fabric', device);
                                  } else {
                                    stockCategoryCubit.categoryFilter(
                                        allItems, value, device);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 40,
                    child: IconOutlineButton(
                      blur: 0,
                      border: 0,
                      icon: Icons.warning,
                      color: Color(0xff5e3443),
                      boxShadow: 0,
                      onPressed: () {
                        stockCategoryCubit.warningFilter(allItems, device);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          device == 'phone'
              ? BlocBuilder(
                  cubit: stockCategoryCubit,
                  builder: (BuildContext context, StockCategoryState state) {
                    return Expanded(
                        child: ListView(
                      children: state.myList,
                    ));
                  })
              : BlocBuilder(
                  cubit: stockCategoryCubit,
                  builder: (BuildContext context, StockCategoryState state) =>
                      Expanded(
                          child: GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    controller: new ScrollController(keepScrollOffset: false),
                    crossAxisCount: 4,
                    children: state.myList,
                  )),
                ),
        ],
      ),
    );
  }
}
