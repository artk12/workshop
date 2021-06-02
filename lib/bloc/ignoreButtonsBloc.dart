// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';

class IgnoreButtonCubit extends Cubit<IgnoreButtonState> {
  IgnoreButtonCubit(state) : super(state);

  void update(bool ignore) => emit(IgnoreButtonState(ignore: ignore));
}

class IgnoreButtonState {
  final bool ignore;

  IgnoreButtonState({this.ignore = false});
}
