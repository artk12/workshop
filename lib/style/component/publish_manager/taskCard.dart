import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      height: 50,
      constraints: BoxConstraints(maxWidth: 60),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("زیپ",style: theme.textTheme.headline4,),
          Text("00:44",style: theme.textTheme.headline4,),
        ],
      ),
    );
  }
}
