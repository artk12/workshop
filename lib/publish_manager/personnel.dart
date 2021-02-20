import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/publish_manager/dialog_add_personnel.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/publish_manager/personnelCard.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class PersonnelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SingleDropDownItemCubit categoryCubit = new SingleDropDownItemCubit(SingleDropDownItemState(value: 'امتیاز'));
    ThemeData theme = Theme.of(context);
    List<String> category = ['امتیاز', 'هشدار', 'حرفه ای', 'تازه کار','کارآموز'];
    void onChange(String val){}
    // WidgetsBinding.instance
    //     .addPostFrameCallback((_) => showDialog(context: context, builder: (context)=>AddPersonnel(),barrierColor: Colors.transparent));

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      height: 70,
                      child: TextField(
                        style: theme.textTheme.bodyText1,
                        onChanged: onChange,
                        decoration: InputDecoration(
                          hintText: 'جستجو...',
                          hintStyle: theme.textTheme.bodyText1
                              .copyWith(color: Colors.white.withOpacity(0.5)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.2),
                                width: 2.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                                width: 2.5),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    height: 40,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff3b4354),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: BlocBuilder(
                        cubit: categoryCubit,
                        builder: (context, SingleDropDownItemState state) =>
                            CustomDropdownButtonHideUnderline(
                              child: CustomDropdownButton<String>(
                                mainAxisAlignment: MainAxisAlignment.start,
                                items: category.map((String value) {
                                  return new CustomDropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(
                                      value,
                                      style: theme.textTheme.headline6,
                                    ),
                                  );
                                }).toList(),
                                value: category
                                    .where((element) => element == state.value)
                                    .first,
                                onChanged: (value) {},
                              ),
                            ),
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 40,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white24)
                      ),
                      child: Text(MyIcons.PLUS,style: MyTextStyle.iconStyle.copyWith(fontSize: 25),),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(itemCount: 10,itemBuilder: (context,index)=>PersonnelCard()),
          )
        ],
      ),
    );
  }
}
