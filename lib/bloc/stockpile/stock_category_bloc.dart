import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/all_items.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/fabric_log.dart';
import 'package:workshop/module/stockpile/item_log.dart';
import 'package:workshop/style/component/stockpile/fabricCardMobile.dart';
import 'package:workshop/style/component/stockpile/fabricCardTablet.dart';
import 'package:workshop/style/component/stockpile/itemCardMobile.dart';
import 'package:workshop/style/component/stockpile/itemCardTablet.dart';

class StockCategoryCubit extends Cubit<StockCategoryState> {
  StockCategoryCubit(StockCategoryState state) : super(state);

  StockCategoryState changeCategory(
      List<AllItem> allItems, String category, String device) {
    List<Widget> myList = [];
    List<AllItem> currentList = [];

    if (category == "fabric") {
      currentList = state.allItem
          .where((element) => element.category == category)
          .toList();

      currentList.forEach((element) {
        if(element.fabric.log == "1"){
          if (device == 'phone') {
            myList.add(FabricCardMobile(
              fabrics: state.getFabrics,
              fabricLogs: state.fabricLogs,
              fabric: element.fabric,
            ));
          } else {
            myList.add(FabricCardTablet(
              fabrics: state.getFabrics,
              fabricLogs: state.fabricLogs,
              fabric: element.fabric,
            ));
          }
        }
      });
    } else {
      currentList = state.allItem
          .where((element) =>
              element.category == 'item' && element.item.category == category)
          .toList();
      currentList.forEach((element) {
        if (device == 'phone') {
          myList.add(ItemCardMobile(
            itemLogs: state.itemLogs,
            item: element.item,
          ));
        } else {
          myList.add(ItemCardTablet(
            item: element.item,
          ));
        }
      });
    }
    return StockCategoryState(allItem: allItems, myList: myList);
  }

  StockCategoryState changeToNoFilter(List<AllItem> allItems, String device) {
    List<Widget> myList = [];

    allItems.forEach((element) {
      if (element.category == "fabric") {
        if(element.fabric.log == "1"){
          if (device == 'phone') {
            myList.add(FabricCardMobile(
              fabrics: state.getFabrics,
              fabric: element.fabric,
            ));
          } else {
            myList.add(FabricCardTablet(
              fabrics: state.getFabrics,
              fabricLogs: state.fabricLogs,
              fabric: element.fabric,
            ));
          }
        }
      } else {
        if (device == 'phone') {
          myList.add(ItemCardMobile(
            itemLogs: state.itemLogs,
            item: element.item,
          ));
        } else {
          myList.add(ItemCardTablet(
            item: element.item,
          ));
        }
      }
    });
    return StockCategoryState(myList: myList, allItem: allItems);
  }

  StockCategoryState changeToWarningFilter(
      List<AllItem> allItems, String device) {
    List<AllItem> currentList = allItems
        .where((element) =>
            element.category == 'item' &&
            int.parse(element.item.quantifierOne) <
                int.parse(element.item.warning))
        .toList();
    List<Widget> myList = [];
    currentList.forEach((element) {
      if (device == 'phone') {
        myList.add(ItemCardMobile(
          itemLogs: state.itemLogs,
          item: element.item,
        ));
      } else {
        myList.add(ItemCardTablet(
          item: element.item,
        ));
      }
    });
    return StockCategoryState(myList: myList, allItem: currentList);
  }

  StockCategoryState searchFilter(
      String value, List<AllItem> allItems, String device) {
    List<AllItem> filterItems = [];

    allItems.forEach((element) {
      if (element.category == "fabric") {
        if(element.fabric.log == "1"){
          if (element.fabric.calite.contains(value)) {
            filterItems.add(element);
          }
        }
      } else {
        if (element.item.name.contains(value)) {
          filterItems.add(element);
        }
      }
    });
    List<Widget> myList = [];

    if (device == "phone") {
      filterItems.forEach((element) {
        if (element.category == "fabric") {
          if(element.fabric.log == "1"){
            myList.add(FabricCardMobile(
              fabrics: state.getFabrics,
              fabric: element.fabric,
            ));
          }
        } else {
          myList.add(ItemCardMobile(
            itemLogs: state.itemLogs,
            item: element.item,
          ));
        }
      });
    } else {
      filterItems.forEach((element) {
        if (element.category == "fabric") {
          if(element.fabric.log == "1"){
            myList.add(FabricCardTablet(
              fabrics: state.getFabrics,
              fabricLogs: state.fabricLogs,
              fabric: element.fabric,
            ));
          }
        } else {
          myList.add(ItemCardTablet(
            item: element.item,
          ));
        }
      });
    }

    return StockCategoryState(allItem: filterItems, myList: myList);
  }

  void noFilter(List<AllItem> allItems, String device) =>
      emit(changeToNoFilter(allItems, device));
  void categoryFilter(List<AllItem> allItems, String category, String device) =>
      emit(changeCategory(allItems, category, device));
  void warningFilter(List<AllItem> allItems, String device) =>
      emit(changeToWarningFilter(allItems, device));
  void search(List<AllItem> allItems, String value, String device) =>
      emit(searchFilter(value, allItems, device));
}

class StockCategoryState {
  List<AllItem> allItem;
  List<Widget> myList;
  List<FabricLog> fabricLogs;
  List<ItemLog> itemLogs;
  StockCategoryState({this.allItem, this.myList, this.fabricLogs, this.itemLogs});

  List<Fabric> get getFabrics {
    List<Fabric> fabrics = [];
    allItem.forEach((element) {
      if(element.category == 'fabric'){
        fabrics.add(element.fabric);
      }
    });
    return fabrics;
  }
}
