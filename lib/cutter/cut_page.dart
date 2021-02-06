import 'package:flutter/material.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/style/component/cutter/cut_card.dart';

class CutPage extends StatelessWidget {
  final PageController pageController;
  final List<Cut> cutList;
  CutPage({this.pageController, this.cutList});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        pageController.animateToPage(0,
            curve: Curves.easeIn, duration: Duration(milliseconds: 200));
        return false;
      },
      child: ListView.builder(
        itemCount: cutList.length,
        itemBuilder: (context, index) => CutCard(
          width: double.maxFinite,
          height: 100,
          cut: cutList[index],
        ),
      ),
    );
  }
}
