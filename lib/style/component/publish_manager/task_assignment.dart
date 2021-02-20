
import 'package:flutter/material.dart';

class TaskAssignmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(5)
      ),
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: double.maxFinite,child: Text("#701-1-3",style: theme.textTheme.headline6,textAlign: TextAlign.end,)),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("x50",style: theme.textTheme.headline4,),
                Text("زیپ",style: theme.textTheme.headline4,),
              ],
            ),
          )
        ],
      )
    );
  }
}
