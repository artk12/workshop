import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String text;
  SecondPage({this.text = ''});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter test web'),
      ),
      body: Container(
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
