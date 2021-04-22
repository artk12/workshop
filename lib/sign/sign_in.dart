//
import 'package:flutter/material.dart';
import 'package:workshop/module/stockpile/user.dart';
import 'package:workshop/request/request.dart';
import 'package:workshop/split_page.dart';
import 'package:workshop/style/component/default_button.dart';
import 'package:workshop/style/component/default_textfield.dart';
import 'package:workshop/style/theme/show_snackbar.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController user = new TextEditingController();
    TextEditingController pass = new TextEditingController();

    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ),
            SizedBox(
              height: 30,
            ),
            DefaultButton(
              title: 'ورود',
              height: 50,
              width: 90,
              onPressed: () async {
                MyShowSnackBar.showSnackBar(context, "لطفا کمی صبر کنید...");
                dynamic res = await MyRequest.getUser(user.text.toString(), pass.text.toString());
                print(res);
                if(res == "not ok"){
                  MyShowSnackBar.showSnackBar(context, "خطا در برقراری اینترنت");
                }else if (res == "wrong" || res == null) {
                  MyShowSnackBar.showSnackBar(
                      context, "رمز عبور یا شماره تماس شما اشتباه است.");
                } else if (res is User || res is SuperUser) {
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
    );
  }
}
