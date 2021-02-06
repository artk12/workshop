

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class NewProjectSizeCubit extends Cubit<NewProjectSizeState>{
  NewProjectSizeCubit(NewProjectSizeState state) : super(state);



  Widget sizeWidget(int index) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TextButton(
        onPressed: (){
          state.sizeWidgets.removeWhere((element) => element.key == index);
          state.sizeTexts.removeWhere((element) => element.key == index);
          emit(NewProjectSizeState(sizeTexts: state.sizeTexts,sizeWidgets: state.sizeWidgets));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          height: 20,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.redAccent.withOpacity(0.3),
          ),
          child: Center(child: Text(MyIcons.CANCEL,style: MyTextStyle.iconStyle.copyWith(fontSize: 15),)),
        ),
      ),

      DefaultTextField(
        padding: EdgeInsets.only(left: 8,right: 8,bottom: 8),
        textEditingController: state.sizeTexts[index].textEditingController,
        textInputType: TextInputType.number,
        width: 60,
        height: 70,
        textAlign: TextAlign.center,
        maxLength: 2,
      ),
    ],
  );

  void add(){
    if(state.sizeWidgets == null && state.sizeTexts == null){
      int newLength = 0;
      state.sizeTexts = [];
      state.sizeWidgets = [];
      MyTextEditKeyValue textEditKeyValue = new MyTextEditKeyValue(key: newLength,textEditingController: TextEditingController());
      state.sizeTexts.add(textEditKeyValue);
      MyWidgetKeyValue widgetKeyValue = new MyWidgetKeyValue(key: newLength,widget: sizeWidget(newLength));
      state.sizeWidgets.add(widgetKeyValue);
      emit(NewProjectSizeState(sizeWidgets: state.sizeWidgets,sizeTexts: state.sizeTexts));
    }else{
      int newLength = state.sizeWidgets.length;
      MyTextEditKeyValue textEditKeyValue = new MyTextEditKeyValue(key: newLength,textEditingController: TextEditingController());
      state.sizeTexts.add(textEditKeyValue);
      MyWidgetKeyValue widgetKeyValue = new MyWidgetKeyValue(key: newLength,widget: sizeWidget(newLength));
      state.sizeWidgets.add(widgetKeyValue);
      emit(NewProjectSizeState(sizeWidgets: state.sizeWidgets,sizeTexts: state.sizeTexts));
    }
  }
}

class NewProjectSizeState{

  List<MyWidgetKeyValue> sizeWidgets;
  List<MyTextEditKeyValue> sizeTexts;

  NewProjectSizeState({this.sizeTexts,this.sizeWidgets});
}
class MyTextEditKeyValue{
  int key;
  TextEditingController textEditingController;
  MyTextEditKeyValue({this.textEditingController,this.key});
}
class MyWidgetKeyValue{
  int key;
  Widget widget;
  MyWidgetKeyValue({this.widget,this.key});
}