import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/request/request.dart';

class PersonnelCard extends StatelessWidget{
  // final Personnel personnel;
  // final UserWarning userWarning;
  // final UserScore userScore;
  // final int monthAbsent;
  final PersonnelCompeteDetail personnelCompeteDetail;
  PersonnelCard({this.personnelCompeteDetail});

@override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color red = Color(0xffff5858);
    Color green = Color(0xff51d04a);
    // DateTime now = DateTime.now();
    // double totalScore = 0;
    // double monthScore = 0;
    // int totalWarning = 0;
    // int monthWarning = 0;
    //
    // if(userScore.id != '0'){
    //   userScore.scores.forEach((element) {
    //     totalScore +=element.score;
    //     if(element.dateTime.year == now.year && element.dateTime.month == now.month ){
    //       monthScore += element.score;
    //     }
    //   });
    // }
    //
    // if(userWarning.id != '0'){
    //   userWarning.warnings.forEach((element) {
    //     totalWarning +=element.warning;
    //     if(element.dateTime.year == now.year && element.dateTime.month == now.month ){
    //       monthWarning += element.warning;
    //     }
    //   });
    // }


    final Widget space = SizedBox(height: 20,);

    return Container(
      margin: EdgeInsets.all(8),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                MyRequest.baseUrl + 'profile/profile_personnel.png'),
          ),
          SizedBox(height: 10,),
          Text(
            personnelCompeteDetail.p.name,
            style: theme.textTheme.headline3,
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "تاریخ تولد :‌ "+personnelCompeteDetail.p.birthDay,
                          style: theme.textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                        space,
                        Text(
                          "تاریخ استخدام :‌ "+personnelCompeteDetail.p.hireDate,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌ "+personnelCompeteDetail.p.level,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "موقعیت :‌ "+personnelCompeteDetail.p.position,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "روزهای آفلاین این ماه : "+"${personnelCompeteDetail.absent}",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌‌ "+personnelCompeteDetail.p.level,
                          style: theme.textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "امتیاز کل :‌ "+"${personnelCompeteDetail.totalScore}",
                          style: theme.textTheme.headline6.copyWith(color: green),
                        ),
                        // space,

                        space,
                        Text(
                          "امتیاز این ماه‌ : "+"${personnelCompeteDetail.monthScore}",
                          style: theme.textTheme.headline6.copyWith(color: green),
                        ),
                        space,
                        Text(
                          "کل هشدارها :‌ "+"${personnelCompeteDetail.totalWarning}",
                          style: theme.textTheme.headline6.copyWith(color: red),
                        ),

                        // space,
                        // Text(
                        //   "میانگین هشدارها : "+"3",
                        //   style: theme.textTheme.headline6.copyWith(color: red),
                        // ),
                        space,
                        Text(
                          "هشدار این ماه :‌‌ "+"${personnelCompeteDetail.monthWarning}",
                          style: theme.textTheme.headline6.copyWith(color: red),
                        ),
                        space,
                        Text(""),
                        space,
                        Text(""),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
