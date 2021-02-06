import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/cutter/cutter_landing.dart';
import 'package:workshop/cutter/cutter_page.dart';
import 'package:workshop/cutter/dialog_new_cut.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/style/app_bar/my_appbar.dart';
import 'package:workshop/style/component/my_icon_button.dart';
import 'package:workshop/style/theme/my_icons.dart';

class Cutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CutterPage();
    return MultiProvider(providers:[
      FutureProvider(create: (_)=>MyRequest.getUserDetail('09176468835', '2778')),
      FutureProvider(create: (_)=>MyList().getCutterMessages()),
      FutureProvider(create: (_)=>MyList().getCutList()),
    ],
      child: ChangeNotifierProvider.value(
        value: RefreshProvider(),
        child: CutterLanding(),
      ),
    );
  }
}
