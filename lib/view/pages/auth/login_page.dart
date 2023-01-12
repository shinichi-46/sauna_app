import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                ), //高さ100
                const Text(
                  'ログインページ',
                  style: TextStyle(fontSize: 40),
                ),
                Container(
                  height: 200,
                ),
                SocialLoginButton(
                  width:300 ,
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SaunaPage.FIRST_EDIT_ACCOUNT.screenName,
                    );
                  },
                ),
              ],
            ),
          )
      ),
    );
  }
}