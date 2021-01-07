
// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';

class DialogItemCubit extends Cubit<DialogItemState>{
  DialogItemCubit(DialogItemState state) : super(state);

  void changeItem(String value)=>emit(DialogItemState(value: value));
}
class DialogItemState{final String value; DialogItemState({this.value = '1'});}