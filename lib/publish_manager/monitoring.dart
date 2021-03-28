import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/style/component/publish_manager/monitor_card.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class MonitoringPage extends StatelessWidget {
  final List<Personnel> personnel;
  MonitoringPage({this.personnel});

  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    TimerStreamer tasks = Provider.of<TimerStreamer>(context);

    ThemeData theme = Theme.of(context);
    void onChange(String val) {}
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  height: 70,
                  child: TextField(
                    style: theme.textTheme.bodyText1,
                    onChanged: onChange,
                    decoration: InputDecoration(
                      hintText: 'جستجو...',
                      hintStyle: theme.textTheme.bodyText1
                          .copyWith(color: Colors.white.withOpacity(0.5)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.2), width: 2.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.2), width: 2.5),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white24)),
                  child: Text(
                    MyIcons.CIRCLE,
                    style: MyTextStyle.iconStyle
                        .copyWith(fontSize: 25, color: Colors.green),
                  ),
                  onPressed: () {
                    tasks.playAll(p,context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.white24)),
                  child: Text(
                    MyIcons.CIRCLE,
                    style: MyTextStyle.iconStyle
                        .copyWith(fontSize: 25, color: Colors.red),
                  ),
                  onPressed: () {
                    tasks.pauseAll(context, p);
                    // p.pause();
                    // tasks.state.monitorItemController.forEach((element) {
                    //   print(element.timerPersonnelCubit.state.plus);
                    // });
                    // startAssigns.forEach((element) {
                    //   print(element.assignPersonnel.score);
                    // });
                    // timerControllerProvider
                    //     .getTimerControllerCubit()
                    //     .pauseAll(context);
                    // timerControllerCubit.state.monitorItemController.forEach((element) {
                    //   print(element.timerPersonnelCubit.state.t1);
                    // });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Color(0xff5e3443),
                    ),
                  ),
                  child: Text(
                    MyIcons.ALERT,
                    style: MyTextStyle.iconStyle.copyWith(fontSize: 28),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          // Expanded(
          //
          //   child:ListView.builder(itemCount: 60,itemBuilder: (BuildContext context, int index) {
          //     return SizedBox(
          //       height: 250,
          //       child: MonitorCard(
          //         maxWidth: double.maxFinite,
          //       ),
          //     );
          //   },
          //
          //   )
          // )
          if (tasks == null) Container() else Expanded(
                  child: RawScrollbar(
                    thumbColor: Colors.white12,
                    isAlwaysShown: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0),
                      child: ListView.builder(
                        itemCount: tasks.monitorItemController.length??0,
                        // itemCount: tasks.state.monitorItemController.length,
                        itemBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 250,
                          child: BlocBuilder(
                            cubit: tasks.monitorItemController[index]
                                .timerPersonnelCubit,
                            builder: (BuildContext context,
                                    TimerPersonnelState state) =>
                                ChangeNotifierProvider.value(
                                  value: p,
                                  child: MonitorCard(
                                    // pause: p.timerControllerProviderState.firstWhere((element) => element.id == timerControllerCubit
                                    //     .state.monitorItemController[index].startAssign.assignPersonnel.id).check,
                                    maxWidth: double.maxFinite,
                                    monitorItemController: tasks.monitorItemController[index],
                                  ),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
