import 'package:bloc/bloc.dart';

class NewProjectSizeCubit extends Cubit<NewProjectSizeState> {
  NewProjectSizeCubit(NewProjectSizeState state) : super(state);

  void add(SizesAndStyle sizesAndStyle) {
    List<SizesAndStyle> list = state.list;
    list.add(sizesAndStyle);
    emit(NewProjectSizeState(list: list));
  }
  void remove(int key){
    List<SizesAndStyle> list = state.list;
    list.removeWhere((element) => element.key == key);
    emit(NewProjectSizeState(list: list));
  }
}

class NewProjectSizeState {
  List<SizesAndStyle> list;

  NewProjectSizeState({this.list});
}
class SizesAndStyle{
  String size;
  String style;
  int key;
  SizesAndStyle({this.size,this.style,this.key = 0});

  factory SizesAndStyle.fromJson(Map map){
    return SizesAndStyle(style: map['styleCode'],size: map['size']);
  }
}
