
import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/style/component/stockpile/dialog_background_blur.dart';

class DialogMessage extends StatelessWidget {
  final List<Message> messages;
  DialogMessage({this.messages});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlurDialogBg(
      child: ListView.builder(itemCount: messages.length,itemBuilder: (BuildContext context,int index)=>Container(
        decoration: BoxDecoration(
          border: Border.all(color:Colors.white60,width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(messages[index].title,style:theme.textTheme.headline3),
            SizedBox(height: 20,),
            Text(messages[index].message,style:theme.textTheme.bodyText2.copyWith(height: 2)),
          ],
        ),
      ),),
    );
  }
}
