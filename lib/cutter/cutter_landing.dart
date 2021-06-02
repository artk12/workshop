import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/cutter/cut_page.dart';
import 'package:workshop/cutter/cutter_drawer_menu.dart';
import 'package:workshop/cutter/cutter_page.dart';
import 'package:workshop/cutter/dialog_new_cut.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';

import 'cutter_dashboard.dart';

class CutterLanding extends StatelessWidget {
  final SuperUser user;
  CutterLanding({this.user});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    PageController pageController = new PageController();
    RefreshProvider refreshProvider = Provider.of(context);
    // SuperUser user = Provider.of<SuperUser>(context);
    List<Message> messages = Provider.of<List<Message>>(context);
    List<Cut> cutList = Provider.of<List<Cut>>(context);


    // List<Cut> cuts = Provider.of<List<Cut>>(context);

    return user == null || messages == null || cutList == null
        ? LoadingPage()
        : Scaffold(
          key: _scaffoldKey,
            drawer: CutterDrawerMenu(
              user: user,
              pageController: pageController,
              scaffoldKey: _scaffoldKey,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  MyAppbar(
                    rightWidget: [
                      MyIconButton(
                        icon: MyIcons.DRAWER_ICON,
                        onPressed: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                      ),
                      MyIconButton(
                          icon: MyIcons.REFRESH,
                          onPressed: () {
                            refreshProvider.refresh();
                          }),
                    ],
                    title: 'داشبورد',
                    leftWidget: [
                      MyIconButton(
                        icon: MyIcons.PLUS,
                        onPressed: () async{
                          // bool check = true;
                          while(true){
                            CutReturn cutReturn = await showDialog(
                              context: context,
                              builder: (context) => NewCutDialog(),
                            );
                            // check = cutReturn.repeat;
                            if(cutReturn == null){
                              break;
                            }else if (cutReturn.repeat == false){
                              break;
                            }
                            if(cutReturn.cut != null){
                              cutList.add(cutReturn.cut);
                              refreshProvider.refresh();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        CutterDashboard(messages: messages,pageController:pageController,cutList: cutList,),
                        CutPage(pageController: pageController,cutList:cutList),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
