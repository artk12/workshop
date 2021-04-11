
import 'package:flutter/material.dart';
import 'package:workshop/module/publish_manager/assignment_log.dart';

class PersonnelLogCard extends StatelessWidget {
  final AssignmentLog a;
  final TextStyle style;
  final double width;
  PersonnelLogCard({this.a,this.style,this.width});

  @override
  Widget build(BuildContext context) {
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
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1, color: Colors.white60),
      ),
      padding: EdgeInsets.all(8),
      child: Center(
        child: RichText(
          // textAlign: TextAlign.center,
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
      ),
    );
  }
}
