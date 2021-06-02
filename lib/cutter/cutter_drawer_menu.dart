import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/request.dart';

class CutterDrawerMenu extends StatelessWidget {
  final SuperUser user;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController pageController;

  CutterDrawerMenu({this.scaffoldKey, this.user, this.pageController});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
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
                fit: BoxFit.contain,
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
                    user.side,
                    style: theme.textTheme.headline2.copyWith(
                      color: Colors.black.withOpacity(0.7),
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
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 14,
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
            title: Text('برش های موجود', style: theme.textTheme.headline2),
            onTap: () {
              scaffoldKey.currentState.openEndDrawer();
              pageController.animateToPage(1,
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);
            },
          ),
        ],
      ),
    );
  }
}
