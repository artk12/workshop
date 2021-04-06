import 'package:flutter/material.dart';

class TaskAssignmentCard extends StatelessWidget {
  final String cutCode;
  final int number;
  final String name;
  final bool isDragging;

  TaskAssignmentCard({this.number, this.cutCode, this.name,this.isDragging=false});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: isDragging?Colors.white.withOpacity(0.1):Colors.white12, borderRadius: BorderRadius.circular(5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  cutCode,
                  style: theme.textTheme.headline6,
                  textAlign: TextAlign.end,
                ),
                Text(
                  "#",
                  style: theme.textTheme.headline6,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDragging?Container():Text(
                    "x$number",
                    style: theme.textTheme.headline4,
                  ),
                  Text(
                    name,
                    style: theme.textTheme.headline4,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}