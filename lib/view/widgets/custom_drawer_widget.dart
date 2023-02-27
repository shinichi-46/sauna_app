import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/repository/authentication/firebase_auth_repository.dart';
import 'package:sauna_app/view/pages/auth/login_page.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';
import 'package:sauna_app/viewmodel/base/post_state_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends ConsumerWidget {
  CustomDrawer({Key? key}) : super(key: key);

  final AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> menuItems = [
      'アカウント情報の設定',
      '利用規約',
      'プライバシーポリシー',
      'ライセンス',
      'ログアウト'
    ];

    final List<String> menuPages = [
      SaunaPage.AGAIN_EDIT_ACCOUNT.screenName,
      'https://shinichi-46.github.io/Privacy_Policy_SaunaRecord/terms_of_service',
      'https://shinichi-46.github.io/Privacy_Policy_SaunaRecord/privacy_policy',
      SaunaPage.LICENSE.screenName
    ];

    return SizedBox(
      width: 280,
      child: Drawer(
          child: Scaffold(
              appBar: AppBar(
                title: const Text(''),
                centerTitle: true,
                backgroundColor: Colors.red[900],
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              body: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () async {
                      if (index == 1 || index == 2) {
                        launchUrl(
                          Uri.parse(menuPages[index]),
                        );
                      } else if (index == 4) {
                        await authRepository.signOut();
                        ref.read(postNotifierProvider.notifier).logOut();
                        ref.read(accountNotifierProvider.notifier).logOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginPage();
                            },
                          ),
                        );
                      } else {
                        Navigator.pushNamed(
                          context,
                          menuPages[index],
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      menuItems[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 40,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(thickness: 1),
                      ],
                    ),
                  );
                },
              ))),
    );
  }
}
