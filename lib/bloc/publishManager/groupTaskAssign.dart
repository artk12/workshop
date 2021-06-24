
import 'package:bloc/bloc.dart';
import 'package:workshop/publish_manager/assignment.dart';

class GroupTaskAssignCubit extends Cubit<GroupTaskAssignState>{
  GroupTaskAssignCubit(GroupTaskAssignState state) : super(state);


  void update(List<NameAndSize> l){
    emit(GroupTaskAssignState(list: l));
  }
}


class GroupTaskAssignState{
  List<NameAndSize> list;
  GroupTaskAssignState({this.list});
}