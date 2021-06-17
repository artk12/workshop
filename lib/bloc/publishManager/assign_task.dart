import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/module/publish_manager/task.dart';

class AssignTaskCubit extends Cubit<AssignTaskState> {
  AssignTaskCubit(AssignTaskState state) : super(state);
  List<FakeAssignmentTask> assignTask = [];

  void calculateUpdate(String cutCode, int number, String name) {
    AssignmentTask s = state.assignTaskUpdate.firstWhere(
        (element) => element.cutCode == cutCode && element.name == name);
    int x = s.number - number;
    state.assignTaskUpdate
        .firstWhere(
            (element) => element.cutCode == cutCode && element.name == name)
        .number = x;
    emit(AssignTaskState(assignTaskUpdate: state.assignTaskUpdate));
  }

  void calculateAddTask(List<AssignmentTask> t) {
    List<AssignmentTask> assignTaskUpdate = state.assignTaskUpdate;

    t.forEach((element) {
      assignTask.add(FakeAssignmentTask.addOriginalToFake(element));
      assignTaskUpdate.add(element);
    });
    emit(AssignTaskState(assignTaskUpdate: assignTaskUpdate));
  }

  void updateTask(String cutCode, int number, String name) =>
      calculateUpdate(cutCode, number, name);

  void addTask(List<AssignmentTask> t) => calculateAddTask(t);

  void clear(){
    emit(AssignTaskState(assignTaskUpdate: []));
  }

  void refresh() {
    emit(AssignTaskState(
        assignTaskUpdate: FakeAssignmentTask.toOriginal(assignTask)));
  }
}

class AssignTaskState {
  final List<AssignmentTask> assignTaskUpdate;

  AssignTaskState({this.assignTaskUpdate});
}
