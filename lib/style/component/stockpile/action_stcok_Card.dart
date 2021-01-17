import 'package:flutter/material.dart';

class WarningStockCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'زیپ کمتر از 10',
            style: theme.textTheme.headline2!.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
