import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/request/query/insert.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/drop_down_background.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class AddPersonnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextEditingController name = new TextEditingController();
    TextEditingController nationalCode = new TextEditingController();
    TextEditingController fatherName = new TextEditingController();
    TextEditingController birthDay = new TextEditingController();
    TextEditingController hireDay = new TextEditingController();
    TextEditingController position = new TextEditingController();


    List<String> levelCategory = ['حرفه ای','تازه کار','کارآموز'];
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    DialogMessageCubit dialogMessage = DialogMessageCubit(DialogMessageState(message: ''));
    SingleDropDownItemCubit levelCategoryCubit = new SingleDropDownItemCubit(SingleDropDownItemState(value: 'حرفه ای'));

    return DialogBg(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "پرسنل جدید",
                style: theme.textTheme.headline3,
              ),
              SizedBox(height: 25),
              // Stack(
              //   alignment: Alignment.center,
              //   children: [
              //     Align(
              //       alignment: Alignment.center,
              //       child: CircleAvatar(
              //         radius: 65,
              //         backgroundColor: Colors.white,
              //       ),
              //     ),
              //     Align(
              //       alignment: Alignment.center,
              //       child: CircleAvatar(
              //         radius: 64,
              //         backgroundColor: Colors.black.withOpacity(0.7),
              //         child: Center(child:Text(MyIcons.CAMERA,style: MyTextStyle.iconStyle.copyWith(fontSize: 30),),),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextField(
                  hint: 'نام و نام خانوادگی',
                  textInputType: TextInputType.text,
                  textEditingController: name,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'کد ملی',
                      textInputType: TextInputType.number,
                      textEditingController: nationalCode,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      hint: 'نام پدر',
                      textInputType: TextInputType.text,
                      textEditingController: fatherName,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'تاریخ تولد',
                      textInputType: TextInputType.datetime,
                      textEditingController: birthDay,
                    ),
                  ),
                  Expanded(
                    child: DefaultTextField(
                      hint: 'تاریخ استخدام',
                      textInputType: TextInputType.datetime,
                      textEditingController: hireDay,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextField(
                      hint: 'سمت',
                      textInputType: TextInputType.text,
                      textEditingController: position,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 84,
                      child: DropDownBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: BlocBuilder(
                            cubit: levelCategoryCubit,
                            builder: (context, SingleDropDownItemState state) =>
                                CustomDropdownButton<String>(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  items: levelCategory.map((String value) {
                                    return new CustomDropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(
                                        value,
                                        style: theme.textTheme.headline6,
                                      ),
                                    );
                                  }).toList(),
                                  value: levelCategory
                                      .where((element) => element == state.value)
                                      .first,
                                  onChanged: (value) {
                                      levelCategoryCubit.changeItem(value);
                                  },
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              BlocBuilder(
                cubit: dialogMessage,
                builder:(BuildContext context,DialogMessageState state)=> Text(state.message),
              ),
              SizedBox(height: 10),
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
                            onPressed: () async {
                              if(name.text.isEmpty || fatherName.text.isEmpty || nationalCode.text.isEmpty || birthDay.text.isEmpty || hireDay.text.isEmpty || position.text.isEmpty){
                                dialogMessage.changeMessage("لطفا تمامی فیلدها را پر کنید...");
                              }else{
                                String query = Insert.queryInsertPersonnel(name.text, nationalCode.text, fatherName.text, birthDay.text, hireDay.text, position.text, levelCategoryCubit.state.value);
                                ignoreButtonCubit.update(true);
                                dialogMessage.changeMessage("کمی صبر کنید...");
                                String result = await MyRequest.simpleQueryRequest('runQueryId.php', query);
                                if(int.tryParse(result) != null){
                                  Personnel p = new Personnel(position: position.text,level: levelCategoryCubit.state.value,nationalCode: nationalCode.text,hireDate: hireDay.text,fatherName: fatherName.text,birthDay: birthDay.text,name: name.text,id: result);
                                  Navigator.pop(context,p);
                                }else{
                                  ignoreButtonCubit.update(false);
                                  dialogMessage.changeMessage("لطفا وضعیت اینترنت خود را چک کنید...");
                                }
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
