import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';
import 'package:workshop/time_format.dart';

class AssignTaskDialog extends StatelessWidget {

  final AssignmentTask alignmentTask;
  final Personnel personnel;

  AssignTaskDialog({this.alignmentTask,this.personnel});

  Widget build(BuildContext context) {
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    DialogMessageCubit dialogTimeCubit = new DialogMessageCubit(DialogMessageState(message: '00:00:00'));
    DialogMessageCubit dialogMessageCubit = new DialogMessageCubit(DialogMessageState(message: ''));

    ThemeData theme = Theme.of(context);
    int time ;
    int quantity = 0;

    if(personnel.level == "کارآموز"){
      time = int.parse(alignmentTask.internTime);
    }else if(personnel.level == "تازه کار"){
      time = int.parse(alignmentTask.amateurTime);
    }else if(personnel.level == "حرفه ای"){
      time = int.parse(alignmentTask.expertTime);
    }

    void onChangeQuantity(String val){

      if(val.isNotEmpty){
        quantity = int.parse(val);
        Duration tpu = Duration(seconds: quantity*time);
        String message = TimeFormat.timeFormatFromDuration(tpu);
        dialogTimeCubit.changeMessage(message);
      }else{
        quantity = 0;
        dialogTimeCubit.changeMessage("00:00:00");
      }
    }

    void onChangeTime(String val){
      dialogTimeCubit.changeMessage(val);
    }

    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "اضافه فعالیت",
                style: theme.textTheme.headline3,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultTextField(
                            label: 'زمان فعالیت(ثانیه)',
                            textInputType: TextInputType.number,
                            onChange: onChangeTime,
                            initText: time.toString(),
                            readOnly: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DefaultTextField(
                            label: 'مقدار',
                            textInputType: TextInputType.number,
                            onChange: onChangeQuantity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: BlocBuilder(
                          cubit: dialogTimeCubit,
                          builder:(BuildContext context,DialogMessageState state) => Text(
                            "زمان کل"+"\n\n${state.message}",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder(cubit: dialogMessageCubit,builder: (BuildContext c,DialogMessageState state)=>Text(state.message)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder(
                cubit: ignoreButtonCubit,
                builder: (BuildContext context, IgnoreButtonState state) =>
                    IgnorePointer(
                  ignoring: state.ignore,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green.withOpacity(0.4),
                              ),
                              backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green.withOpacity(0.4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                MyIcons.CHECK,
                                style:
                                    MyTextStyle.iconStyle.copyWith(fontSize: 30),
                              ),
                            ),
                            onPressed: (){
                              if(quantity == 0){
                                dialogMessageCubit.changeMessage("هیچ مقداری وارد نشده است.");
                              } else if(quantity > alignmentTask.number){
                                dialogMessageCubit.changeMessage("تعداد وارد شده از تعداد باقیمانده بیشتر است.");
                              }else{
                                Duration d = TimeFormat.stringToDuration(dialogTimeCubit.state.message);
                                int time = d.inSeconds;
                                String name = alignmentTask.name;
                                int number = quantity;
                                Navigator.pop(context,AssignTaskPersonnel(name: name,number: number,personnel: personnel,time: time,cutCode: alignmentTask.cutCode));
                              }
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.red.withOpacity(0.4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                MyIcons.CANCEL,
                                style:
                                    MyTextStyle.iconStyle.copyWith(fontSize: 30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
