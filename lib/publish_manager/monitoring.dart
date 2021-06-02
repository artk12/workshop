import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/publishManager/timer_controller.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/provider/publish_manager_pages_controller.dart';
import 'package:workshop/style/component/publish_manager/monitor_card.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class MonitoringMobilePage extends StatefulWidget {
  final List<Personnel> personnel;
  final double itemHeight;
  final double itemWidth;
  final TimerStreamer timerStreamer;
  final PublishManagerPageController pageController;

  // final PageController streamPageController;
  final String dashboard;

  MonitoringMobilePage(
      {this.personnel,
      this.itemHeight,
      this.itemWidth,
      this.timerStreamer,
      this.pageController,
      this.dashboard = "non"});

  @override
  _MonitoringMobilePageState createState() => _MonitoringMobilePageState();
}

class _MonitoringMobilePageState extends State<MonitoringMobilePage> {
  @override
  Widget build(BuildContext context) {
    TimerControllerProvider p = Provider.of<TimerControllerProvider>(context);
    // print("hh : "+widget.timerStreamer.monitorItemController[0].startAssign.assignPersonnel.play);
    // TimerControllerProvider p = new TimerControllerProvider();
    // TimerStreamer tasks = Provider.of<TimerStreamer>(context);
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
      body: Container(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     widget.pageController.changePage(LOG);
        //     // Navigator.of(context).push(
        //     //     MaterialPageRoute(builder: (context) => PersonnelLogMobile()));
        //     // widget.streamPageController.animateToPage(2, duration: Duration(milliseconds: 250 ), curve: Curves.easeIn);
        //   },
        //   backgroundColor: theme.canvasColor,
        //   child: Text(
        //     MyIcons.LOG,
        //     style: MyTextStyle.iconStyle,
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
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
                                color: Colors.white.withOpacity(0.2),
                                width: 2.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.4),
                                width: 2.5),
                          ),
                          border: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
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
                        MyIcons.PLAY,
                        style: MyTextStyle.iconStyle
                            .copyWith(fontSize: 25, color: Colors.green),
                      ),
                      onPressed: () {
                        widget.timerStreamer.playAll(p, context);
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
                        MyIcons.PAUSE,
                        style: MyTextStyle.iconStyle
                            .copyWith(fontSize: 25, color: Color(0xFF7F1510)),
                      ),
                      onPressed: () {
                        widget.timerStreamer.pauseAll(context, p);
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
              if (widget.timerStreamer == null)
                Container()
              else
                Expanded(
                  child: RawScrollbar(
                    thumbColor: Colors.white12,
                    radius: Radius.circular(5),
                    isAlwaysShown: true,
                    thickness: widget.itemWidth != 0 ? 15 : null,
                    child: widget.itemWidth != 0
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
                                  widget.timerStreamer.monitorItemController
                                          .length ??
                                      0,
                                  (index) => getPercentageItems(widget
                                              .timerStreamer
                                              .monitorItemController[index]
                                              .startAssign
                                              .assignPersonnel
                                              .id) &&
                                          (widget
                                                  .timerStreamer
                                                  .monitorItemController[index]
                                                  .startAssign
                                                  .assignPersonnel
                                                  .name
                                                  .contains(p.search) ||
                                              widget
                                                  .timerStreamer
                                                  .monitorItemController[index]
                                                  .startAssign
                                                  .assignPersonnel
                                                  .cutCode
                                                  .contains(p.search) ||
                                              widget
                                                  .timerStreamer
                                                  .monitorItemController[index]
                                                  .startAssign
                                                  .p
                                                  .name
                                                  .contains(p.search))
                                      ? Container(
                                          constraints: BoxConstraints(
                                              maxHeight: 350, maxWidth: 350),
                                          child: BlocBuilder(
                                              cubit: widget
                                                  .timerStreamer
                                                  .monitorItemController[index]
                                                  .timerPersonnelCubit,
                                              builder: (BuildContext context,
                                                  TimerPersonnelState state) {
                                                // if(){
                                                //   return Container();
                                                // }
                                                return ChangeNotifierProvider
                                                    .value(
                                                  value: p,
                                                  child: MonitorCard(
                                                    maxWidth: double.maxFinite,
                                                    serverPlay: widget
                                                        .timerStreamer
                                                        .monitorItemController[
                                                            index]
                                                        .startAssign
                                                        .assignPersonnel
                                                        .play,
                                                    serverPlayDateTime: widget
                                                        .timerStreamer
                                                        .monitorItemController[
                                                            index]
                                                        .startAssign
                                                        .assignPersonnel
                                                        .playDateTime,
                                                    serverRemainingTime: widget
                                                        .timerStreamer
                                                        .monitorItemController[
                                                            index]
                                                        .startAssign
                                                        .assignPersonnel
                                                        .remainingTime,
                                                    monitorItemController: widget
                                                            .timerStreamer
                                                            .monitorItemController[
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
                            itemCount: widget.timerStreamer
                                    .monitorItemController.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) =>
                                getPercentageItems(widget
                                            .timerStreamer
                                            .monitorItemController[index]
                                            .startAssign
                                            .assignPersonnel
                                            .id) &&
                                        (widget
                                                .timerStreamer
                                                .monitorItemController[index]
                                                .startAssign
                                                .assignPersonnel
                                                .name
                                                .contains(p.search) ||
                                            widget
                                                .timerStreamer
                                                .monitorItemController[index]
                                                .startAssign
                                                .assignPersonnel
                                                .cutCode
                                                .contains(p.search) ||
                                            widget
                                                .timerStreamer
                                                .monitorItemController[index]
                                                .startAssign
                                                .p
                                                .name
                                                .contains(p.search))
                                    ? SizedBox(
                                        height: 250,
                                        child: BlocBuilder(
                                          cubit: widget
                                              .timerStreamer
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
                                                serverPlay: widget
                                                    .timerStreamer
                                                    .monitorItemController[
                                                        index]
                                                    .startAssign
                                                    .assignPersonnel
                                                    .play,
                                                serverPlayDateTime: widget
                                                    .timerStreamer
                                                    .monitorItemController[
                                                        index]
                                                    .startAssign
                                                    .assignPersonnel
                                                    .playDateTime,
                                                serverRemainingTime: widget
                                                    .timerStreamer
                                                    .monitorItemController[
                                                        index]
                                                    .startAssign
                                                    .assignPersonnel
                                                    .remainingTime,
                                                maxWidth: double.maxFinite,
                                                monitorItemController: widget
                                                        .timerStreamer
                                                        .monitorItemController[
                                                    index],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : Container(),
                          ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
