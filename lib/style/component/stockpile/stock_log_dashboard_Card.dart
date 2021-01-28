import 'package:flutter/material.dart';

import '../dashboard_card_blur_background.dart';

class LogDashboardCard extends StatelessWidget {
  final String amount;
  final String quantify;
  final String name;
  final String year;
  final String month;
  final String day;
  final String log;
  final String person;
  
  LogDashboardCard({this.quantify,this.person,this.amount,this.month,this.year,this.log,this.day,this.name});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    String import(){
      return amount +' ' + quantify+ ' '+name+' '+ ' در تاریخ '+'$year/$month/$day'+' اضافه شد. ';
    }

    String export(){
      return amount +' ' + quantify+' '+' در تاریخ '+'$year/$month/$day' + ' توسط '+person+' خارج شد.';
    }

    return DashboardBlurBackgroundCard(
      color:log == '1'? Colors.green.withOpacity(0.2):Colors.redAccent.withOpacity(0.2),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              log == '1'? import():export(),
              style: theme.textTheme.headline2.copyWith(fontSize: 14,height: 2),
            ),
          ],
        ),
      ),
    );
  }
}
