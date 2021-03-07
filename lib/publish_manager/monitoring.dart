import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/publish_manager/personnel.dart';
import 'package:workshop/module/publish_manager/task.dart';
import 'package:workshop/style/component/publish_manager/monitor_card.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class MonitoringPage extends StatelessWidget {
  final List<Personnel> personnel;
  MonitoringPage({this.personnel});

  @override
  Widget build(BuildContext context) {
    List<AssignTaskPersonnel> tasks = Provider.of<List<AssignTaskPersonnel>>(context)??[];

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
                  padding: EdgeInsets.symmetric(vertical: 8),
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
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white24)
                  ),
                  child: Text(
                    MyIcons.CIRCLE,
                    style: MyTextStyle.iconStyle.copyWith(fontSize: 25,color: Colors.green),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white24)
                  ),
                  child: Text(
                    MyIcons.CIRCLE,
                    style: MyTextStyle.iconStyle.copyWith(fontSize: 25,color: Colors.red),
                  ),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff5e3443))
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
          Expanded(
            child: ListView.builder(itemCount: 10,itemBuilder: (context,index)=>SizedBox(height: 250,child: MonitorCard(maxWidth: double.maxFinite,))),
          )
        ],
      ),
    );
  }
}
