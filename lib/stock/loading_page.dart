import 'package:flutter/material.dart';
import 'package:workshop/style/background/stock_background.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StockBackground(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
