import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final String quantify;
  final String name;
  final String quantifier;

  StockCard({this.quantify, this.name, this.quantifier});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.black.withOpacity(0.1)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  style: theme.textTheme.headline4,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  quantifier,
                  style: theme.textTheme.headline4,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  quantify,
                  style: theme.textTheme.headline4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
