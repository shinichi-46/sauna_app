import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/repository/authentication/firebase_auth_repository.dart';
import 'package:sauna_app/view/arguments/login_argument.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginPage extends StatelessWidget {

  LoginPage({Key? key}) : super(key: key);

  final AuthRepository authRepository = AuthRepository();

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
                  onPressed: () async {
                    try {
                      final userCredential = await authRepository.signInWithGoogle();
                      String _uid = userCredential.user!.uid;
                      final CollectionReference collection = FirebaseFirestore.instance.collection('user');
                      DocumentSnapshot<Object?> doc = await collection.doc(_uid).get();
                      if (doc.exists) {
                        final userData = doc.data();
                        Navigator.pushNamed(
                          context,
                          SaunaPage.TAB.screenName,
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
          )
      ),
    );
  }
}