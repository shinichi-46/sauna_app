import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/pages/account/again_edit_account_page.dart';
import 'package:sauna_app/view/pages/account/first_edit_account_page.dart';
import 'package:sauna_app/view/pages/auth/login_page.dart';
import 'package:sauna_app/view/pages/post/update_post_page.dart';
import 'package:sauna_app/view/pages/tabs/tab_container.dart';

class AppComponent extends StatelessWidget {
  const AppComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SaunaPage.LOGIN.screenName,
      routes: {
        SaunaPage.TAB.screenName: (_) => TabContainer(),
        SaunaPage.LOGIN.screenName: (_) => LoginPage(),
        SaunaPage.FIRST_EDIT_ACCOUNT.screenName: (_) => FirstEditAccountPage(),
        SaunaPage.AGAIN_EDIT_ACCOUNT.screenName: (_) => AgainEditAccountPage(),
        SaunaPage.UPDATE_POST.screenName: (_) => UpdatePostPage(),
        SaunaPage.LICENSE.screenName: (_) => LicensePage(),
      }
    );
  }
}
