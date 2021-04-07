import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final double itemHeight;
  final double itemWidth;

  MonitoringPage({this.personnel, this.itemHeight, this.itemWidth});

  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    TimerStreamer tasks = Provider.of<TimerStreamer>(context);
    ThemeData theme = Theme.of(context);

    int checkWarning() {
      if (p.warning) {
        return 26;
      } else {
        return 101;
      }
    }

    bool getPercentageItems(String id) {
      try {
        if (p.timerControllerProviderState
                .firstWhere((element) => element.id == id)
                .percent <
            checkWarning()) {
          return true;
        }
      } catch (e) {
        return true;
      }
      return false;
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {},backgroundColor: theme.canvasColor,child: Text(MyIcons.LOG,style: MyTextStyle.iconStyle,),),
      body: SafeArea(
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
                      onChanged: p.updateSearch,
                      decoration: InputDecoration(
                        hintText: 'جستجو...',
                        hintStyle: theme.textTheme.bodyText1
                            .copyWith(color: Colors.white.withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.2), width: 2.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.4), width: 2.5),
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
                      tasks.playAll(p, context);
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
                    onPressed: () {
                      p.updateWarning(!p.warning);
                    },
                  ),
                ),
              ],
            ),
            if (tasks == null)
              Container()
            else
              Expanded(
                child: RawScrollbar(
                  thumbColor: Colors.white12,
                  radius: Radius.circular(5),
                  isAlwaysShown: true,
                  thickness: itemWidth != 0?15:null,
                  child: itemWidth != 0
                      ? Padding(
                    padding: EdgeInsets.only(left: 25),
                        child: SingleChildScrollView(
                          child: Wrap(
                              // maxCrossAxisExtent: 390,
                              // crossAxisAlignment: WrapCrossAlignment.start,
                              // alignment: WrapAlignment.spaceBetween,
                              // runAlignment: WrapAlignment.spaceBetween,
                              // childAspectRatio: (itemWidth / itemHeight),
                              // controller:
                              //     new ScrollController(keepScrollOffset: false),
                              // crossAxisCount: 3,
                              // crossAxisCount: 2,
                              children: List.generate(
                                tasks.monitorItemController.length ?? 0,
                                (index) => getPercentageItems(tasks
                                            .monitorItemController[index]
                                            .startAssign
                                            .assignPersonnel
                                            .id) &&
                                        (tasks.monitorItemController[index]
                                                .startAssign.assignPersonnel.name
                                                .contains(p.search) ||
                                            tasks.monitorItemController[index]
                                                .startAssign.assignPersonnel.cutCode
                                                .contains(p.search) ||
                                            tasks.monitorItemController[index]
                                                .startAssign.p.name
                                                .contains(p.search))
                                    ? Container(
                                      constraints: BoxConstraints(maxHeight: 350,maxWidth: 350),
                                      child: BlocBuilder(
                                          cubit: tasks
                                              .monitorItemController[index]
                                              .timerPersonnelCubit,
                                          builder: (BuildContext context,
                                              TimerPersonnelState state) {
                                            // if(){
                                            //   return Container();
                                            // }
                                            return ChangeNotifierProvider.value(
                                              value: p,
                                              child: MonitorCard(
                                                maxWidth: double.maxFinite,
                                                monitorItemController:
                                                    tasks.monitorItemController[
                                                        index],
                                              ),
                                            );
                                          }),
                                    )
                                    : Container(),
                              ),
                            ),
                        ),
                      )
                      : ListView.builder(
                          itemCount: tasks.monitorItemController.length ?? 0,
                          itemBuilder: (BuildContext context, int index) =>
                              getPercentageItems(tasks
                                          .monitorItemController[index]
                                          .startAssign
                                          .assignPersonnel
                                          .id) &&
                                      (tasks.monitorItemController[index]
                                              .startAssign.assignPersonnel.name
                                              .contains(p.search) ||
                                          tasks
                                              .monitorItemController[index]
                                              .startAssign
                                              .assignPersonnel
                                              .cutCode
                                              .contains(p.search) ||
                                          tasks.monitorItemController[index]
                                              .startAssign.p.name
                                              .contains(p.search))
                                  ? SizedBox(
                                      height: 250,
                                      child: BlocBuilder(
                                          cubit: tasks
                                              .monitorItemController[index]
                                              .timerPersonnelCubit,
                                          builder: (BuildContext context,
                                              TimerPersonnelState state) {
                                            // if(){
                                            //   return Container();
                                            // }
                                            return ChangeNotifierProvider.value(
                                              value: p,
                                              child: MonitorCard(
                                                maxWidth: double.maxFinite,
                                                monitorItemController:
                                                    tasks.monitorItemController[
                                                        index],
                                              ),
                                            );
                                          }),
                                    )
                                  : Container(),
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
