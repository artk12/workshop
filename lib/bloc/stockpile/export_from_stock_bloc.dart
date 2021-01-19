// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:workshop/module/stockpile/fabric.dart';
import 'package:workshop/module/stockpile/item.dart';



class ExportFromStockPileCubit extends Cubit<ExportFromStockPileState>{
  ExportFromStockPileCubit(ExportFromStockPileState state) : super(state);

  void changeItem(Item? value) => emit(ExportFromStockPileState(item: value,items: state.items,itemSelected: state.itemSelected,fabric: null));
  void updateItems(List<Item> itemNameAvailable) => emit(ExportFromStockPileState(item: state.item,items: itemNameAvailable,itemSelected: state.itemSelected,fabric: null));
  void updateFabric(Fabric? fabric) => emit(ExportFromStockPileState(item: null,items: null,itemSelected: state.itemSelected,fabric: fabric));
  void changeToFabric(String val) => emit(ExportFromStockPileState(item: null,items: null,itemSelected: val,fabric: null));
}

class ExportFromStockPileState {
  final List<Item>? items;
  final Item? item;
  final String? itemSelected;
  final Fabric? fabric;
  ExportFromStockPileState({this.item , this.items,this.itemSelected,this.fabric});
}
