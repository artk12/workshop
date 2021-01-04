import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workshop/style/component/custom_drop_down.dart';
import 'package:workshop/style/component/default_button.dart';

class DialogItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white30,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'اضافه کالا جدید',
                  style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'bold',
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child: CustomDropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        items: <String>['زیب', 'دکمه', 'زیپ', 'دکمه']
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
                        value: 'زیپ',
                        onChanged: (_) {},
                      ),
                    ),
                    DefaultButton(
                      title: 'اعمال',
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  title: 'اضافه پارچه جدید',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  title: 'اضافه آیتم جدید',
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
