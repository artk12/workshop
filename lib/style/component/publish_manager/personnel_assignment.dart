import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class PersonnelAssignmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget tasks() {
      return Container(
        margin: EdgeInsets.only(bottom: 4),
        child: Row(
          children: [
            // Text('#',style: theme.textTheme.headline6.copyWith(fontSize: 10),),
            Text(
              "701" + "_" + "30" + "_" + "1",
              style: theme.textTheme.headline6.copyWith(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'زیپ',
              style: theme.textTheme.headline4,
            ),
            Expanded(
              child: Container(),
            ),
            Text(
              'x 50',
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '00:40',
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: 6, left: 5, right: 5),
            width: double.maxFinite,
            child: Text(
              "حرفه ای",
              style: theme.textTheme.headline6,
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6, left: 5, right: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.maxFinite,
                  child: Text(
                    "پرسنل",
                    style: theme.textTheme.headline3,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                tasks(),
                tasks(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(child: Text("مدت زمان وظایف : "+"7:20",style: theme.textTheme.headline6,)),
          ),
        ],
      ),
    );
  }
}
