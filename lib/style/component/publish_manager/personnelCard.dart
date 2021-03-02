import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/request/request.dart';

class PersonnelCard extends StatelessWidget{
  final Personnel personnel;
  PersonnelCard({this.personnel});

@override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color red = Color(0xffff5858);
    Color green = Color(0xff51d04a);

    final Widget space = SizedBox(height: 20,);
    return Container(
      margin: EdgeInsets.all(8),
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white12,
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
            personnel.name,
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
                          "تاریخ تولد :‌ "+personnel.birthDay,
                          style: theme.textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                        space,
                        Text(
                          "تاریخ استخدام :‌ "+personnel.hireDate,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌ "+personnel.level,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "موقعیت :‌ "+personnel.position,
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        //TODO personnel offline date
                        Text(
                          "روزهای آفلاین این ماه : "+"3",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌‌ "+personnel.level,
                          style: theme.textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //TODO : personnel score and warning
              Expanded(
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "امتیاز کل :‌ "+"10",
                          style: theme.textTheme.headline6.copyWith(color: green),
                        ),
                        space,
                        Text(
                          "میانگین امتیاز :‌ "+"101",
                          style: theme.textTheme.headline6.copyWith(color: green),
                        ),
                        space,
                        Text(
                          "امتیاز این ماه‌ : "+"5",
                          style: theme.textTheme.headline6.copyWith(color: green),
                        ),
                        space,
                        Text(
                          "کل هشدارها :‌ "+"12",
                          style: theme.textTheme.headline6.copyWith(color: red),
                        ),
                        space,
                        Text(
                          "میانگین هشدارها : "+"3",
                          style: theme.textTheme.headline6.copyWith(color: red),
                        ),
                        space,
                        Text(
                          "هشدار این ماه :‌‌ "+"3",
                          style: theme.textTheme.headline6.copyWith(color: red),
                        ),
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
