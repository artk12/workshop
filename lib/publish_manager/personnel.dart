import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/publishManager/personnel_filter.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/bloc/stockpile/single_drop_down_bloc.dart';
import 'package:workshop/module/publish_manager/absent.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/score.dart';
import 'package:workshop/module/publish_manager/warning.dart';
import 'package:workshop/publish_manager/dialog_add_personnel.dart';
import 'package:workshop/style/component/dropdownWithOutNullSafety.dart';
import 'package:workshop/style/component/publish_manager/personnelCard.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

final _sigInFormKey = GlobalKey<FormState>();
class PersonnelPage extends StatefulWidget {
  final List<Personnel> personnel;
  final RefreshProvider refreshProvider;
  final List<UserScore> userScores;
  final List<UserWarning> userWarnings;
  final List<Absent> absents;

  PersonnelPage(
      {this.personnel,
      this.refreshProvider,
      this.userScores,
      this.absents,
      this.userWarnings});

  @override
  _PersonnelPageState createState() => _PersonnelPageState();
}

class _PersonnelPageState extends State<PersonnelPage> {
  PersonnelFilterCubit personnelFilterCubit;
  SingleDropDownItemCubit categoryCubit;
  List<PersonnelCompeteDetail> personnelCompleteDetail = [];
  // final _formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  List<String> category = [
    'امتیاز',
    'هشدار',
    'حرفه ای',
    'تازه کار',
    'کارآموز'
  ];

  @override
  void initState() {
    categoryCubit = new SingleDropDownItemCubit(SingleDropDownItemState(value: 'امتیاز'));
    widget.personnel.forEach((p) {
      UserScore userScore;
      UserWarning userWarning;
      int monthAbsent = 0;
      try{
        monthAbsent = widget.absents.where((element) => element.id == p.id).toList().length;
      }catch(e){}
      try{
        userScore = widget.userScores.firstWhere((element) => element.userId == p.id);
      }catch(e){
        userScore = UserScore(id: '0',scores: [],userId: '0');
      }
      try{
        userWarning = widget.userWarnings.firstWhere((element) => element.userId == p.id);
      }catch(e){
        userWarning = UserWarning(id: '0',warnings: [],userId: '0');
      }
      double totalScore = 0;
      double monthScore = 0;
      int totalWarning = 0;
      int monthWarning = 0;

      if(userScore.id != '0'){
        userScore.scores.forEach((element) {
          totalScore +=element.score;
          if(element.dateTime.year == now.year && element.dateTime.month == now.month ){
            monthScore += element.score;
          }
        });
      }

      if(userWarning.id != '0'){
        userWarning.warnings.forEach((element) {
          totalWarning +=element.warning;
          if(element.dateTime.year == now.year && element.dateTime.month == now.month ){
            monthWarning += element.warning;
          }
        });
      }
      personnelCompleteDetail.add(PersonnelCompeteDetail(absent: monthAbsent,p: p,monthScore: monthScore,monthWarning: monthWarning,totalScore: totalScore,totalWarning: totalWarning));
    });
    personnelCompleteDetail.sort((a,b)=> b.totalScore.compareTo(a.totalScore));

    personnelFilterCubit = PersonnelFilterCubit(PersonnelFilterCubitState(filterList: personnelCompleteDetail,myList: personnelCompleteDetail));


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // List<Personnel> staff = Provider.of<List<Personnel>>(context);
    ThemeData theme = Theme.of(context);

    void onChange(String val) {
      personnelFilterCubit.search(val);
    }

    return Scaffold(
      body: SafeArea(
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
                        child: Form(
                          key: _sigInFormKey,
                          child: TextFormField(
                            style: theme.textTheme.bodyText1,
                            onChanged: onChange,
                            // autofocus: true,
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
                              onChanged: (value) {
                                  categoryCubit.changeItem(value);
                                  personnelFilterCubit.filter(value);
                              },
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
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.white24)),
                        child: Text(
                          MyIcons.PLUS,
                          style: MyTextStyle.iconStyle.copyWith(fontSize: 25),
                        ),
                        onPressed: () async {
                          Personnel p = await showDialog(
                              context: context,
                              builder: (context) => AddPersonnel(),
                              barrierColor: Colors.black54);
                          widget.personnel.add(p);
                          widget.refreshProvider.refresh();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder(
                cubit: personnelFilterCubit,
                builder: (BuildContext context, PersonnelFilterCubitState state) => ListView.builder(
                    itemCount:state.filterList.length,
                    itemBuilder: (context, index) {
                      return PersonnelCard(personnelCompeteDetail: state.filterList[index],);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
