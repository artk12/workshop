
import 'package:bloc/bloc.dart';

class NewCutDialogCubit extends Cubit<NewCutDialogState>{
  NewCutDialogCubit(NewCutDialogState state) : super(state);

  void changeMessage(String message) => emit(NewCutDialogState(message: message));
}


class NewCutDialogState{
  final String message;
  NewCutDialogState({this.message=''});
}