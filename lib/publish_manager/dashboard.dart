import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/personnel/dialog_message.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/publish_manager/dashboard_monitor.dart';
import 'package:workshop/publish_manager/monitoring.dart';
import 'package:workshop/publish_manager/personnel_log_mobile.dart';
import 'package:workshop/style/component/dashboard_card_background.dart';
import 'package:workshop/style/component/message_stock_Card.dart';
import 'package:workshop/style/component/publish_manager/notification_card.dart';
import 'package:workshop/style/component/publish_manager/personnel_log_card.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';

// ignore: must_be_immutable
class Dashboard extends StatelessWidget {
  // final PageController streamPageController;
  final String device;
  TimerControllerProvider timerControllerProvider;
  final double itemHeight;
  final double itemWidth;
  final List<Personnel> personnel;
  final TextStyle style;
  final PersonnelLogProvider personnelLogProvider;
  final TimerStreamer timerStreamer;
  final PublishManagerPageController pageController;
  final List<Message> messages;
  final List<AssignmentLog> assignmentLogs;

  Dashboard({
    this.personnelLogProvider,
    this.personnel,
    this.device,
    this.itemHeight,
    this.itemWidth,
    this.style,
    this.timerStreamer,
    this.timerControllerProvider,
    this.pageController,
    this.messages,
    this.assignmentLogs,
  });

  @override
  Widget build(BuildContext context) {
    Widget space(double height) => SizedBox(
          height: height,
        );
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.bodyText2.copyWith(height: 2);

    Widget title(String title, Function() onPress) {
      return GestureDetector(
        onTap: onPress,
        child: Row(
          children: [
            space(15),
            // Text(
            //   icon,
            //   style: MyTextStyle.iconStyle,
            // ),
            Container(
              padding: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: theme.primaryColor),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Text(title, style: theme.textTheme.headline2),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            space(10),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('اعلانها', () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => device == "phone"
                      //         ? ChangeNotifierProvider(
                      //             create: (_) => personnelLogProvider,
                      //             child: PersonnelLogMobile(
                      //               style: style,
                      //               personnelLogProvider: personnelLogProvider,
                      //             ),
                      //           )
                      //         : Container()));
                      // device == 'phone'?
                    }),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: assignmentLogs.length,
                          itemBuilder: (BuildContext context, int index) =>
                              PersonnelLogCard(
                                width:200,
                                style: style,
                                a: assignmentLogs[index],
                              )),
                    ),
                  ],
                ),
              ),
            ),
            space(20),
            DashboardCardBackground(
              child: Container(
                height: 280,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(
                      'مانیتورینگ',
                      () {
                        pageController.changePage(MONITOR);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (BuildContext context) =>
                                    // ChangeNotifierProvider(
                                    //   create: (_) => timerControllerProvider,
                                    //   child: MonitoringMobilePage(
                                    //     dashboard: 'd',
                                    //     personnel: personnel,
                                    //     itemWidth: itemWidth,
                                    //     itemHeight: itemHeight,
                                    //     timerStreamer: timerStreamer,
                                    //   ),
                                    // )));
                        // pageController.changePage(MONITOR);
                        // timerControllerProvider = new TimerControllerProvider(timerControllerProviderState: []);
                        // Navigator.of(context).push(
                        // MaterialPageRoute(
                        //   builder: (context) => ChangeNotifierProvider(
                        //     create: (_) => timerControllerProvider,
                        //     child: MonitoringMobilePage(
                        //       dashboard: 'd',
                        //       personnel: personnel,
                        //       itemWidth: itemWidth,
                        //       itemHeight: itemHeight,
                        //       tasks: timerStreamer,
                        //       // streamPageController:streamPageController
                        //     ),
                        //   ),
                        // ),
                        // );
                      },
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ChangeNotifierProvider(
                        create: (_) => timerControllerProvider,
                        child: DashboardMonitoringMobilePage(
                          // dashboard: "check",
                          personnel: personnel,
                          itemWidth: itemWidth,
                          itemHeight: itemHeight,
                          tasks: timerStreamer,
                          // streamPageController:streamPageController
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            space(20),
            DashboardCardBackground(
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title('پیامها', () {
                      showDialog(context: context, builder: (BuildContext context)=>DialogMessage(messages: messages,));
                    }),
                    SizedBox(
                      height: 2,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: messages.length,
                          itemBuilder: (context, index) => MessageCard(
                                message: Message(
                                    id: messages[index].id,
                                    message: messages[index].message,
                                    title: messages[index].title),
                              )),
                    ),
                  ],
                ),
              ),
            ),
            space(20),
          ],
        ),
      ),
    );
  }
}
