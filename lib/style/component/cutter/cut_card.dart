import 'package:flutter/material.dart';
import 'package:workshop/cutter/cutter_detail_page.dart';
import 'package:workshop/module/cutter/cut.dart';

class CutCard extends StatelessWidget {
  final double width;
  final double height;
  final Cut cut;

  CutCard({this.width = 200, this.height, this.cut});

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CutterDetailPage(
            cutDetail: cut,
          ),
          barrierColor: Colors.black38,
        );
      },
      child: Container(
        width: width,
        height: height,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("کد پروژه : " + cut.project.id),
                    SizedBox(
                      height: 10,
                    ),
                    Text("کالیته : " + cut.fabric.calite),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(cut.year + "/" + cut.month + "/" + cut.day),
                    //TODO : Cut code
                    // Text(
                    //   "#" + 'cut.cutCode',
                    //   style: theme.textTheme.headline4,
                    //   textDirection: TextDirection.ltr,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
