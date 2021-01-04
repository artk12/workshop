import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/blur_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_textfield.dart';

class AddNewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget space = SizedBox(
      height: 20,
    );

    return Scaffold(
      body: StockBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              StockAppbar(
                title: 'اضافه به انبار',
              ),
              space,
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'آیتم جدید',
                    style: theme.textTheme.headline2!.copyWith(
                      fontFamily: 'bold',
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 15,
                        )
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: theme.primaryColor),
                  ),
                ),
              ),
              space,
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'اسم آیتم',
                    ),
                  )),
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
                            items: <String>['بسته بندی', 'خرج کار']
                                .map((String value) {
                              return new CustomDropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'light', color: Colors.white),
                                ),
                              );
                            }).toList(),
                            value: 'خرج کار',
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(
                      label: 'شمارنده اول',
                    ),
                  )),
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
                            items: <String>['متر', 'کیلوگرم', 'بسته']
                                .map((String value) {
                              return new CustomDropdownMenuItem<String>(
                                value: value,
                                child: new Text(
                                  value,
                                  style: TextStyle(
                                      fontFamily: 'light', color: Colors.white),
                                ),
                              );
                            }).toList(),
                            value: 'بسته',
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(label: 'شمارنده دوم'),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(label: 'تعداد هشدار'),
                  )),
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 0),
                      ),
                    ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shadowColor: Colors.black.withOpacity(0.5),
                            backgroundColor: Colors.green.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white.withOpacity(0.85),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 8,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            shadowColor: Colors.black.withOpacity(0.5),
                            backgroundColor: Colors.red.withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            side: BorderSide(
                              width: 1.0,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white.withOpacity(0.85),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
