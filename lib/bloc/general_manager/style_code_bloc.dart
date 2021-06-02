

import 'package:bloc/bloc.dart';

class StyleCodeCubit extends Cubit<StyleCodeState>{
  StyleCodeCubit(StyleCodeState state) : super(state);

  void changeStyleCodeCheck(String name , bool check){
    List<StyleCodeNames> list = [];
    state.styleChecks.forEach((element) {
      bool t = element.check;
      if(element.name == name){
        t = check;
      }
      list.add(StyleCodeNames(check: t,name: element.name));
    });
    StyleCodeState styleCodeState = new StyleCodeState(styleChecks: list);
    emit(styleCodeState);
  }
}

class StyleCodeState{
  List<StyleCodeNames> styleChecks;
  StyleCodeState({this.styleChecks});
}

class StyleCodeNames{
  String name;
  bool check;
  String shortName;
  StyleCodeNames({this.name,this.check,this.shortName});
}