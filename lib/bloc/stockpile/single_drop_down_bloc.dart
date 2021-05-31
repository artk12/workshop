// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';

class SingleDropDownItemCubit extends Cubit<SingleDropDownItemState> {
  SingleDropDownItemCubit(SingleDropDownItemState state) : super(state);

  void changeItem(String value) => emit(SingleDropDownItemState(value: value));
}

class SingleDropDownItemState {
  final String value;

  SingleDropDownItemState({this.value = '1'});
}
