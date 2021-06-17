import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/module/cutter/cut.dart';
import 'package:workshop/module/publish_manager/absent.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/score.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/module/publish_manager/warning.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/provider/stream_page_provider.dart';
import 'package:workshop/publish_manager/assignment.dart';
import 'package:workshop/publish_manager/personnel.dart';
import 'package:workshop/publish_manager/stream_pages.dart';
import 'package:workshop/publish_manager/tasks.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/device_detector.dart';
import 'package:workshop/style/theme/my_icons.dart';

import 'drawer_menu.dart';

class PublishManager extends StatelessWidget {
  final SuperUser user;

  PublishManager({this.user});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<TaskFolder> tasksFolder = Provider.of<List<TaskFolder>>(context);
    List<Cut> cuts = Provider.of<List<Cut>>(context);
    List<Personnel> personnel = Provider.of<List<Personnel>>(context);
    List<UserScore> userScores = Provider.of<List<UserScore>>(context);
    List<UserWarning> userWarning = Provider.of<List<UserWarning>>(context);
    List<Absent> absents = Provider.of<List<Absent>>(context);
    ThemeData theme = Theme.of(context);
    TextStyle style = theme.textTheme.bodyText2.copyWith(height: 2);
    Size size = MediaQuery.of(context).size;
    double itemHeight = 0;
    double itemWidth = 0;
    RefreshProvider refreshProvider = Provider.of(context);
    String device = DeviceDetector.deviceDetector();
    if (device == "tablet") {
      itemHeight = (size.height - kToolbarHeight - 20) / 1.5;
    }
    TimerControllerProvider timerControllerProvider =
        TimerControllerProvider(timerControllerProviderState: []);
    PersonnelLogProvider personnelLogProvider = new PersonnelLogProvider();
    StreamPageProvider streamPageProvider = new StreamPageProvider();

    PublishManagerPageController streamPageController = Provider.of(context);
    List<Message> messages = Provider.of(context) ?? [];
    PageController pageController =
        new PageController(initialPage: streamPageController.pageView);

    return user == null ||
            tasks == null ||
            cuts == null ||
            personnel == null ||
            absents == null ||
            userScores == null ||
            userWarning == null || tasksFolder == null
        ? LoadingPage()
        : Scaffold(
            key: scaffoldKey,
            drawer: DrawerMenu(
                user: user,
                scaffoldKey: scaffoldKey,
                dashboardPageController: streamPageController,
                pageController: pageController,
                messages: messages,
                streamPageController: streamPageController),
            body: SafeArea(
              child: Column(
                children: [
                  MyAppbar(
                    title: "داشبورد",
                    rightWidget: [
                      MyIconButton(
                        icon: MyIcons.DRAWER_ICON,
                        onPressed: () {
                          scaffoldKey.currentState.openDrawer();
                        },
                      ),
                    ],
                    leftWidget: [
                      // MyIconButton(
                      //   icon: MyIcons.PLUS,
                      //   onPressed: () {},
                      // )
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MultiProvider(
                          providers: [
                            StreamProvider(
                              create: (_) => MyList.getAssignmentLogs(),
                            ),
                            StreamProvider(
                              create: (_) =>
                                  MyList.getRealAssignmentTask(personnel),
                            ),
                          ],
                          child: StreamPages(
                            style: style,
                            streamPageProvider: streamPageProvider,
                            timerControllerProvider: timerControllerProvider,
                            itemWidth: itemWidth,
                            itemHeight: itemHeight,
                            device: device,
                            personnel: personnel,
                            messages: messages,
                            // streamPageController: steamPageController,
                            personnelLogProvider: personnelLogProvider,
                            pageController: streamPageController,
                          ),
                        ),
                        PersonnelPage(
                          personnel: personnel,
                          absents: absents,
                          userScores: userScores,
                          userWarnings: userWarning,
                        ),
                        AssignmentPage(
                          //TODO : Cut code
                            cuts: cuts,
                            tasks: tasks,
                            taskFolders: tasksFolder,
                            personnel: personnel,
                            assignPersonnelCubit:
                                streamPageController.assignPersonnelCubit,
                            assignTaskCubit:
                                streamPageController.assignTaskCubit,
                            pageController: pageController,
                            streamPageController: streamPageController),
                        ChangeNotifierProvider.value(
                          value: refreshProvider,
                          child: TasksPage(
                            tasks: tasks,
                            taskFolders:tasksFolder
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
/*
StreamBuilder(
          stream: MyList.getAssignmentLogs(),
          builder:(BuildContext context,AsyncSnapshot snap)=> StreamBuilder(
            builder:(BuildContext context,AsyncSnapshot snap)=> PublishManagerLanding(
            user: user, cuts: cuts, personnel: personnel, tasks: tasks,timerControllerProvider:timerControllerProvider,personnelLogProvider:personnelLogProvider),
          ),
        )
 */
// StreamProvider(
// create: (_) => MyList.getAssignmentLogs(),
// ),
// StreamProvider(
// create: (_) => MyList.getRealAssignmentTask(personnel),
// ),

/*
Stack(
                      // controller: normalPageController,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        StreamPages(
                          style: style,
                          timerControllerProvider: timerControllerProvider,
                          itemWidth: itemWidth,
                          itemHeight: itemHeight,
                          device: device,
                          personnel: personnel,
                          streamPageController: steamPageController,
                          personnelLogProvider: personnelLogProvider,
                        ),
                        PersonnelPage(
                            staff: staff, refreshProvider: refreshProvider),
                        AssignmentPage(
                          cuts: cuts,
                          tasks: tasks,
                          personnel: personnel,
                        ),
                        TasksPage(
                          tasks: tasks,
                          refreshProvider: refreshProvider,
                        ),
                      ],
                    ),
 */
