import 'package:bloc/bloc.dart';
import 'package:workshop/module/publish_manager/task.dart';

class AssignPersonnelCubit extends Cubit<AssignPersonnelState> {
  AssignPersonnelCubit(AssignPersonnelState state) : super(state);

  void calculateUpdate(AssignTaskPersonnel p) {
    List<AssignTaskPersonnel> current = state.assignments;
    current.add(p);
    emit(AssignPersonnelState(assignments: current));
  }

  void update(AssignTaskPersonnel t) => calculateUpdate(t);

  void refresh() {
    emit(AssignPersonnelState(assignments: []));
  }
}

class AssignPersonnelState {
  List<AssignTaskPersonnel> assignments;

  AssignPersonnelState({this.assignments});
}
