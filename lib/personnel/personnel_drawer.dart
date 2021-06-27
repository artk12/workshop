import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/dialog_message.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/main.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/request/query/update.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class PersonnelDrawer extends StatelessWidget {
  final User user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ScoreCubit scoreCubit;

  PersonnelDrawer({this.user, this.scaffoldKey, this.scoreCubit});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    DialogMessageCubit dialogMessageCubit =
        DialogMessageCubit(DialogMessageState(message: ""));
    String pass = '';

    void onChange(String val) {
      pass = val;
    }

    return SafeArea(
      child: Container(
        color: Colors.black,
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(MyRequest.baseUrl + '/' + user.profile),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.level,
                      style: theme.textTheme.headline2.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        shadows: [Shadow(color: Colors.black, blurRadius: 3)],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      user.name,
                      style: theme.textTheme.headline1.copyWith(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder(
                      cubit: scoreCubit,
                      builder: (BuildContext context, ScoreState state) => Text(
                        "امتیاز کل : " + state.score.toString(),
                        style: theme.textTheme.headline1.copyWith(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('امار', style: theme.textTheme.headline2),
              onTap: () {
                scaffoldKey.currentState.openEndDrawer();
              },
            ),
            ListTile(
              title: Text('تغییر گذرواژه', style: theme.textTheme.headline2),
              onTap: () {
                scaffoldKey.currentState.openEndDrawer();
                showDialog(
                    context: context,
                    builder: (context) => DialogBg(
                          child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 340, maxHeight: 300),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "تفییر گذرواژه",
                                  style: theme.textTheme.headline1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DefaultTextField(
                                  hint: "گذرواژه جدید",
                                  onChange: onChange,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                BlocBuilder(
                                    cubit: dialogMessageCubit,
                                    builder: (BuildContext context,
                                            DialogMessageState state) =>
                                        Text(state.message)),
                                SizedBox(height: 10),
                                BlocBuilder(
                                  cubit: ignoreButtonCubit,
                                  builder: (BuildContext context,
                                          IgnoreButtonState state) =>
                                      IgnorePointer(
                                    ignoring: state.ignore,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                  (states) => Colors.green
                                                      .withOpacity(0.4),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                  (states) => Colors.green
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  MyIcons.CHECK,
                                                  style: MyTextStyle.iconStyle
                                                      .copyWith(fontSize: 30),
                                                ),
                                              ),
                                              onPressed: () async {
                                                ignoreButtonCubit.update(true);
                                                dialogMessageCubit
                                                    .changeMessage(
                                                        "کمی صیر کنید...");
                                                String res = await MyRequest
                                                    .simpleQueryRequest(
                                                        'stockpile/runQuery.php',
                                                        Update
                                                            .updatePassPersonnel(
                                                                user.id, pass));
                                                if (res.trim() != "OK") {
                                                  dialogMessageCubit.changeMessage(
                                                      "خطا در برقراری ارتباط");
                                                  ignoreButtonCubit
                                                      .update(false);
                                                } else {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty
                                                        .resolveWith(
                                                  (states) => Colors.red
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  MyIcons.CANCEL,
                                                  style: MyTextStyle.iconStyle
                                                      .copyWith(fontSize: 30),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ));
              },
            ),
            ListTile(
              title: Text('خروج', style: theme.textTheme.headline2),
              onTap: () async{
                MySharedPreferences().clean();
                scaffoldKey.currentState.openEndDrawer();
                await Future.delayed(Duration(milliseconds: 250));
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
