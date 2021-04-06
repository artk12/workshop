import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/bloc/refresh_provider.dart';
import 'package:workshop/cutter/cutter_landing.dart';
import 'package:workshop/request/mylist.dart';
import 'package:workshop/request/request.dart';

class Cutter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return CutterPage();
    return MultiProvider(providers:[
      FutureProvider(create: (_)=>MyRequest.getSuperUserDetail('09176468835', '2778')),
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
