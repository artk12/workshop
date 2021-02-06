import 'package:flutter/material.dart';
import 'package:workshop/cutter/cutter_page.dart';
import 'package:workshop/cutter/dialog_new_cut.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';

class Cutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CutterPage();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              title: 'داشبورد',
              rightWidget: [
                MyIconButton(
                  icon: MyIcons.PLUS,
                  onPressed: () {
                    showDialog(
                        context: context, builder: (context) => NewCutDialog());
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
