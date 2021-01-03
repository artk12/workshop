import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/style/app_bar/stock_appbar.dart';
import 'package:workshop/style/background/stock_background.dart';
import 'package:workshop/style/component/custom_drop_down.dart';

class AvailableItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Widget space = SizedBox(
      height: 10,
    );
    Widget item = Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'زیپ',
          style: theme.textTheme.headline2,
        ),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: theme.primaryColor),
        ),
      ),
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
              item,
              space,
              // Row(
              //   children: [
              //
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Container(
              //           height: 60,
              //           child: InputDecorator(
              //             decoration: InputDecoration(
              //               // enabledBorder: theme.inputDecorationTheme.enabledBorder
              //             ),
              //             child: CustomDropdownButton<String>(
              //               icon: Icon(
              //                 Icons.arrow_drop_down,
              //                 color: Colors.white,
              //               ),
              //               mainAxisAlignment: MainAxisAlignment.spaceAround,
              //               items: <String>['زیب', 'دکمه', 'زیپ', 'دکمه']
              //                   .map((String value) {
              //                 return new CustomDropdownMenuItem<String>(
              //                   value: value,
              //                   child: new Text(
              //                     value,
              //                     style: TextStyle(
              //                         fontFamily: 'light', color: Colors.white),
              //                   ),
              //                 );
              //               }).toList(),
              //               value: 'زیپ',
              //               onChanged: (_) {},
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // space,
              // Row(
              //   children: [
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: TextField(
              //           cursorColor: theme.primaryColor,
              //           decoration: InputDecoration(
              //               enabledBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(
              //                     color: theme.dividerColor, width: 1.0),
              //               ),
              //               labelText: 'تعداد اخطار',
              //               labelStyle: theme.textTheme.bodyText1
              //                   .copyWith(color: theme.primaryColor)),
              //           style: theme.textTheme.bodyText1,
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: TextField(
              //           cursorColor: theme.primaryColor,
              //           decoration: InputDecoration(
              //               enabledBorder: OutlineInputBorder(
              //                 borderSide: BorderSide(
              //                     color: theme.dividerColor, width: 1.0),
              //               ),
              //               labelText: 'شمارنده دوم',
              //               labelStyle: theme.textTheme.bodyText1
              //                   .copyWith(color: theme.primaryColor)),
              //           style: theme.textTheme.bodyText1,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  // Expanded(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: ClipRect(
                  //       child: BackdropFilter(
                  //         filter: ImageFilter.blur(sigmaY: 20,sigmaX: 20),
                  //         child: Container(
                  //           color: Colors.black26,
                  //           child: Expanded(
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: TextField(
                  //                 cursorColor: theme.primaryColor,
                  //                 decoration: InputDecoration(
                  //                     labelText: 'شمارنده اول',
                  //                     labelStyle: theme.textTheme.bodyText1
                  //                         .copyWith(color: theme.primaryColor)),
                  //                 style: theme.textTheme.bodyText1,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 40,sigmaX: 40),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextField(
                              cursorColor: theme.primaryColor,
                              decoration: InputDecoration(border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                  labelText: 'شمارنده اول',
                                  labelStyle: theme.textTheme.bodyText1!
                                      .copyWith(color: theme.primaryColor,fontSize: 16,height: 0.5)),
                              style: theme.textTheme.bodyText1,
                            ),
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
