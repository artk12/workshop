
import 'package:flutter/material.dart';
import 'package:workshop/style/component/default_button.dart';

class NotificationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        constraints: BoxConstraints(maxWidth: 300, minWidth: 150),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'پرسنل ایکس 9:20'+'وظیفه را شروع کرده و انتظار میرود تا 10:00'+'وظیفه خود را به پایان برساند',
              style: theme.textTheme.headline6.copyWith(height: 2),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButton(onPressed: (){}, title: 'پروفایل ایکس',),
              ],
            )
          ],
        ),
      ),
    );
  }
}
