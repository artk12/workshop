import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/style/component/dialog_bg.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  MessageCard({this.message});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    String m;
    if (message.message.length > 100) {
      m = message.message.substring(0, 100) + '...';
    } else {
      m = message.message;
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DialogBg(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Text(
                  message.message,
                  style: theme.textTheme.headline6,
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: 200, minWidth: 150),
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
              message.title,
              style: theme.textTheme.headline4,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              m,
              style: theme.textTheme.headline6.copyWith(height: 2),
            ),
          ],
        ),
      ),
    );
  }
}
