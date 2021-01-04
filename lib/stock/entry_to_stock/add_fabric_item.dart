import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/default_textfield.dart';

class AddFabricItem extends StatelessWidget {
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
                    'پارچه',
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
                        label: 'سازنده',
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
                      child: DefaultTextField(label: 'کالیته'),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextField(label: 'متراژ'),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(label: 'رنگ'),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DefaultTextField(label: 'تعداد تکه'),
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DefaultTextField(
                        maxLine: 3,
                        label: 'توضیحات',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
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
              space,
            ],
          ),
        ),
      ),
    );
  }
}
