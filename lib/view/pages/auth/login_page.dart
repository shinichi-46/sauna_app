import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'LoginPage',
                  style: TextStyle(fontSize: 50),
                ),
                const Text(
                  'ごきげんよう！',
                  style: TextStyle(fontSize: 20),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SaunaPage.FIRST_EDIT_ACCOUNT.screenName,
                    );
                  },
                  child: const Text('初回アカウント設定画面に遷移する')
                ),
              ],
            ),
          )
      ),
    );
  }
}