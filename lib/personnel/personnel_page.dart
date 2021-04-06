import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/message.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/personnel/personnel_landing.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/stock/loading_page.dart';

class PersonnelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    List<Message> messages = Provider.of<List<Message>>(context);

    return user == null || messages == null
        ? LoadingPage()
        :FutureProvider(create: (_)=>MyList().getUserTasks(user.id),child: PersonnelLandingPage(user: user,messages:messages));
  }
}
