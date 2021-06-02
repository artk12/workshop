import 'package:bloc/bloc.dart';
import 'package:workshop/module/publish_manager/personnel.dart';

class PersonnelFilterCubit extends Cubit<PersonnelFilterCubitState> {
  PersonnelFilterCubit(PersonnelFilterCubitState state) : super(state);

  void search(String search) {
    List<PersonnelCompeteDetail> searchList = state.myList
        .where((element) => element.p.name.contains(search))
        .toList();
    emit(PersonnelFilterCubitState(
        myList: state.myList, filterList: searchList));
  }

  void filter(String filter) {
    if (filter == "امتیاز") {
      List<PersonnelCompeteDetail> check = [];
      state.filterList = state.myList;
      state.filterList.sort((a, b) => b.totalScore.compareTo(a.totalScore));
      check = state.filterList;
      emit(PersonnelFilterCubitState(myList: state.myList, filterList: check));
    } else if (filter == "هشدار") {
      List<PersonnelCompeteDetail> check = [];
      state.filterList = state.myList;
      state.filterList.sort((a, b) => b.totalWarning.compareTo(a.totalWarning));
      check = state.filterList;
      emit(PersonnelFilterCubitState(myList: state.myList, filterList: check));
    } else if (filter == "حرفه ای") {
      emit(PersonnelFilterCubitState(
          myList: state.myList,
          filterList: state.myList
              .where((element) => element.p.level == filter)
              .toList()));
    } else if (filter == "تازه کار") {
      emit(PersonnelFilterCubitState(
          myList: state.myList,
          filterList: state.myList
              .where((element) => element.p.level == filter)
              .toList()));
    } else if (filter == "کارآموز") {
      emit(PersonnelFilterCubitState(
          myList: state.myList,
          filterList: state.myList
              .where((element) => element.p.level == filter)
              .toList()));
    }
  }
}

class PersonnelFilterCubitState {
  List<PersonnelCompeteDetail> myList;
  List<PersonnelCompeteDetail> filterList;

  PersonnelFilterCubitState({this.myList, this.filterList});
}
/*
  static List<PersonnelCompeteDetail> gnomeSort(List<PersonnelCompeteDetail> arr, int n) {
    int index = 0;

    while (index < n) {
      if (index == 0) index++;
      if (arr[index].totalScore <= arr[index - 1].totalScore)
        index++;
      else {
        PersonnelCompeteDetail temp;
        temp = arr[index];
        arr[index] = arr[index - 1];
        arr[index - 1] = temp;
        index--;
      }
    }
    return arr;
  }
 */
