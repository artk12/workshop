import 'package:bloc/bloc.dart';

class DialogMessageCubit extends Cubit<DialogMessageState> {
  DialogMessageCubit(DialogMessageState state) : super(state);

  void changeMessage(String message) =>
      emit(DialogMessageState(message: message));
}

class DialogMessageState {
  String message;

  DialogMessageState({this.message});
}
