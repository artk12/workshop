//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/my_shared_preferences.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/split_page.dart';
import 'package:workshop/stock/loading_page.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    UserPass userName = Provider.of(context);

    return userName == null? LoadingPage(): userName.user != "not found" && userName.pass != "not found"
        ? FutureBuilder(
            future:
                MyRequest.getUser(userName.user, userName.pass),
            builder: (BuildContext c, AsyncSnapshot s) {
              if(s.hasData){
                if(s.data == 'wrong'){
                  return LogInPage();
                }else{
                  try{
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SplitPages(
                            user: s.data,
                          ),
                        ),
                      );
                    });
                  }catch(e){}
                }
              }
              return LoadingPage();
            },
          )
        : LogInPage();
  }
}
class LogInPage extends StatefulWidget {

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                      child: Text(
                        "به برنامه کارگاه خوش آمدید",
                        style: theme.textTheme.headline2,
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 350),
                    child: DefaultTextField(
                      textEditingController: user,
                      label: "شماره تماس",
                      textInputType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 350),
                    child: DefaultTextField(
                        textEditingController: pass,
                        label: "رمز عبور",
                        textInputType: TextInputType.number),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  DefaultButton(
                    title: 'ورود',
                    height: 50,
                    width: 90,
                    onPressed: () async {
                      MyShowSnackBar.showSnackBar(
                          context, "لطفا کمی صبر کنید...");
                      dynamic res = await MyRequest.getUser(
                          user.text.toString(), pass.text.toString());
                      if (res == "not ok") {
                        MyShowSnackBar.showSnackBar(
                            context, "خطا در برقراری اینترنت");
                      } else if (res == "wrong" || res == null) {
                        MyShowSnackBar.showSnackBar(context,
                            "رمز عبور یا شماره تماس شما اشتباه است.");
                      } else if (res is User || res is SuperUser) {
                        MySharedPreferences().save(user.text.toString(), pass.text.toString());
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SplitPages(
                              user: res,
                            ),
                          ),
                        );
                      }
                    },
                    backgroundColor: Color(0xFF466813),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

