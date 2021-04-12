import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/module/publish_manager/score.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/personnel/dialog_message.dart';
import 'package:workshop/personnel/personnel_drawer.dart';
import 'package:workshop/personnel/personnel_task_list.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/component/personnel/task_item.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:flutter/foundation.dart';


class PersonnelLandingPage extends StatelessWidget {
  final User user;
  final List<Message> messages;
  final TaskItemProvider provider;

  PersonnelLandingPage({this.user,this.messages,this.provider});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
    List<AssignPersonnel> tasks = Provider.of<List<AssignPersonnel>>(context) ?? [];

    UserScore userScore = Provider.of(context);
    double totalScore = 0;
    if(userScore != null){
      if(userScore.id != '0'){
        userScore.scores.forEach((element) {
          totalScore += element.score;
        });
      }
    }
    provider.taskSetter = tasks;

    return Scaffold(
      key: scaffoldKey,
      drawer: PersonnelDrawer(
        scaffoldKey: scaffoldKey,
        user: user,
        totalScore:totalScore,
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyAppbar(
              title: 'داشبورد',
              rightWidget: [
                MyIconButton(
                  icon: MyIcons.DRAWER_ICON,
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Image.asset('asset/images/statistics.png'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('گزارش',style: Theme.of(context).textTheme.bodyText2,),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: (){
                    showDialog(barrierColor: Colors.black12,context: context, builder: (BuildContext context)=>DialogMessage(messages: messages,));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(child: Image.asset('asset/images/message_personnel.png'),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('پیامها',style: Theme.of(context).textTheme.bodyText2,),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    onPressed: (){},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Container(
                              child: Image.asset(
                                  'asset/images/notification_personnel.png'),
                            ),
                            Positioned(
                              top: 18,
                              right: 20,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                        offset: Offset(0, 5))
                                  ],
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('اعلانها',style: Theme.of(context).textTheme.bodyText2,),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ChangeNotifierProvider.value(
                value: provider,
                child: MyTaskList(user:user),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
