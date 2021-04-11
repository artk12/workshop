import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';
import 'package:workshop/provider/personnel_log_provider.dart';
import 'package:workshop/style/component/publish_manager/timeControllerProvider.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class PersonnelLogMobile extends StatelessWidget {
  final TextStyle style;
  final PersonnelLogProvider personnelLogProvider;
  // final PageController streamPageController;
  final Axis axis;
  PersonnelLogMobile({this.style,this.personnelLogProvider,this.axis = Axis.vertical,});
  @override
  Widget build(BuildContext context) {
    // List<AssignmentLog> assignmentLogs =
    //     Provider.of<List<AssignmentLog>>(context) ?? [];
    // PersonnelLogProvider personnelLogProvider =
    //     Provider.of<PersonnelLogProvider>(context);
    // if (assignmentLogs.length >= personnelLogProvider.a.length) {
    //   personnelLogProvider.assignmentLogSetter = assignmentLogs;
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     MyShowSnackBar.showSnackBar(context, "وضعیت اینترنت خود را چک کنید..");
    //   });
    // }

    return Scaffold(
      body: Container(
        child: ListView.builder(
          scrollDirection: axis,
          controller: new ScrollController(),
          itemCount: personnelLogProvider.a.length,
          itemBuilder: (BuildContext context, int index) {
            AssignmentLog a = personnelLogProvider.a[index];
            String text;
            String cutCode;
            String done;
            Color color;
            if (a.log == "1") {
              text = a.personnelName +
                  " فعالیت " +
                  a.taskName +
                  " با کد برش ";
                  cutCode = a.cutCode;
              done = " شروع کرد.";
              color = Colors.green.withOpacity(0.1);
            } else {
              text = a.personnelName +
                  " فعالیت " +
                  a.taskName +
                  " با کد برش " ;
              cutCode = a.cutCode;
              done = " به اتمام رساند.";
              color = Colors.red.withOpacity(0.1);
            }
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 1, color: Colors.white60),
              ),
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  style: style,
                  children: [
                    TextSpan(
                      text: text,
                    ),
                    TextSpan(
                      style: style.copyWith(fontSize: 0.1),
                      text: "a",
                    ),
                    TextSpan(
                      text: "$cutCode",
                    ),
                    TextSpan(
                      text: done,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
