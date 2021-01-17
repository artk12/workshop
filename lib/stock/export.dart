import 'package:flutter/material.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';

class Export extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<String> nameCategory = ['خرج کار', 'بسته بندی'];
    Widget space = SizedBox(
      height: 10, //20
    );
    return Scaffold(
      body: StockBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StockAppbar(
                title: 'خروج از انبار',
              ),
              space,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: CustomDropdownButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            mainAxisAlignment: MainAxisAlignment.start,
                            items: nameCategory.map((String value) {
                              return new CustomDropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'light', color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      height: 84,
                      child: BlurBackground(
                        child: CustomDropdownButtonHideUnderline(
                          child: CustomDropdownButton<String>(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                            mainAxisAlignment: MainAxisAlignment.start,
                            items: nameCategory.map((String value) {
                              return new CustomDropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'light', color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              space,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 7),
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.white))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'موجودی : ',
                          style: theme.textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 6)
                              ]),
                        ),
                        Text(
                          '10',
                          style: theme.textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 6)
                              ]),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: 10,),
                ],
              ),
              space,
            ],
          ),
        ),
      ),
    );
  }
}
