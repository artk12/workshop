import 'package:flutter/material.dart';
import 'package:workshop/request/request.dart';

import 'CircleProgress.dart';

class MonitorCard extends StatelessWidget {
  final double maxWidth;
  MonitorCard({this.maxWidth = 300});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth, minWidth: 150),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            child: Text(
              '#'+'36_1_107',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(MyRequest.baseUrl +
                            'profile/profile_personnel.png'),
                        radius: 45,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'مهناز افشار',
                              style: theme.textTheme.headline4,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'فعالیت',
                              style: theme.textTheme.headline5,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'فعالیت ها : ' + '2/4',
                              style: theme.textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [MyCircularProgress()],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCircularProgress extends StatefulWidget {
  @override
  _MyCircularProgressState createState() => _MyCircularProgressState();
}

class _MyCircularProgressState extends State<MyCircularProgress> {
  ThemeData theme(context) => Theme.of(context);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: CustomPaint(
        foregroundPainter: CircleProgress(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "32:30",
              style: theme(context).textTheme.headline2,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "10:30",
              style: theme(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
