

import 'package:bloc/bloc.dart';

class CutCodeAssignCubit extends Cubit<CutCodeAssignState>{
  CutCodeAssignCubit(CutCodeAssignState state) : super(state);

  void changeStyleCodeCheck(String cutCode , bool check){
    List<CutCodeCheck> list = [];
    state.cutCodeChecks.forEach((element) {
      bool t = element.check;
      if(element.cutCode == cutCode){
        t = check;
      }
      list.add(CutCodeCheck(check: t,cutCode: element.cutCode));
    });
    CutCodeAssignState styleCodeState = new CutCodeAssignState(cutCodeChecks: list);
    emit(styleCodeState);
  }

  List<CutCodeCheck> getCutCodeChecks(){
    try{
      return state.cutCodeChecks.where((element) => element.check == true).toList();
    }catch(e){
      return [];
    }
  }
}

class CutCodeAssignState{
  List<CutCodeCheck> cutCodeChecks;
  CutCodeAssignState({this.cutCodeChecks});
}

class CutCodeCheck{
  String cutCode;
  bool check;
  CutCodeCheck({this.cutCode,this.check});
}