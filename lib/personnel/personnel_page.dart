import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/personnel/score_cubit.dart';
import 'package:workshop/module/publish_manager/score.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/personnel/personnel_landing.dart';
import 'package:workshop/provider/taskItemProvider.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/loading_page.dart';

class PersonnelPage extends StatelessWidget {
  final User user;

  PersonnelPage({this.user});

  @override
  Widget build(BuildContext context) {
    List<Message> messages = Provider.of<List<Message>>(context);
    UserScore userScore = Provider.of(context);

    TaskItemProvider provider = new TaskItemProvider();
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

    double totalScore = 0;
    if (userScore != null) {
      if (userScore.id != '0') {
        userScore.scores.forEach((element) {
          totalScore += element.score;
        });
      }
    }
    ScoreCubit scoreCubit = new ScoreCubit(ScoreState(score: totalScore));

    return user == null || messages == null || userScore == null
        ? LoadingPage()
        : StreamProvider(
            create: (_) => MyList().getUserTasks(user.id),
            child: PersonnelLandingPage(
                user: user,
                messages: messages,
                provider: provider,
                scoreCubit: scoreCubit,
                scaffoldKey: scaffoldKey),
          );
  }
}
