import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/repository/authentication/firebase_auth_repository.dart';
import 'package:sauna_app/view/arguments/login_argument.dart';
import 'package:sauna_app/view/pages/tabs/tab_container.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

// Todo: reiverpodを使うため、ConsumerWidgetまたはConsumerStatefulWidgetに変更する(riverpod)
class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final AuthRepository authRepository = AuthRepository();

  @override
  //Todo: "WidgetRef ref"を追加する(riverpod)
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
            width: 300,
            buttonType: SocialLoginButtonType.google,
            onPressed: () async {
              try {
                final userCredential = await authRepository.signInWithGoogle();
                if (userCredential == null) {
                  // Sign in flow canceled.
                  return null;
                }
                String _uid = userCredential.user!.uid;
                //Todo: Widgetで使用する(riverpod)　ローディング　ログインの際にユーザーIDを処理する
                bool canFetched = await ref
                    .read(accountNotifierProvider.notifier)
                    .canFetch(uid: _uid);
                if (canFetched) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return TabContainer();
                      },
                    ),
                  );
                } else {
                  Navigator.pushNamed(
                    context,
                    SaunaPage.FIRST_EDIT_ACCOUNT.screenName,
                    arguments: LoginArguments(uid: _uid),
                  );
                }
              } on FirebaseAuthException catch (e) {
                print('FirebaseAuthException');
                print('${e.code}');
              } on Exception catch (e) {
                print('Other Exception');
                print('${e.toString()}');
              }
            },
          ),
        ],
      ),
    ));
  }
}
