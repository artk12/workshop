import 'package:flutter/material.dart';
import 'package:workshop/request/request.dart';

class PersonnelCard extends StatelessWidget {
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
            "پرسنل",
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
                          "تاریخ تولد :‌ "+"1398/9/9",
                          style: theme.textTheme.headline6,
                          textAlign: TextAlign.start,
                        ),
                        space,
                        Text(
                          "تاریخ استخدام :‌ "+"1398/9/9",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌ "+"متوسظ",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "موقعیت :‌ "+"خیاط",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "روزهای آفلاین این ماه : "+"3",
                          style: theme.textTheme.headline6,
                        ),
                        space,
                        Text(
                          "سطح :‌‌ "+"خیاط",
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
