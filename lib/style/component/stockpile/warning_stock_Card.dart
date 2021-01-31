import 'package:flutter/material.dart';

class WarningStockCard extends StatelessWidget {
  final String name;
  final String warning;
  final String quantify;
  WarningStockCard({this.name,this.quantify,this.warning});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:Colors.black.withOpacity(0.3),
        border: Border.all(color: Color(0xff7a1818).withOpacity(0.5),width: 1.5),
        borderRadius:BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name + ' به کمتر از '+warning+' '+quantify+' رسید. ',
            style: theme.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
