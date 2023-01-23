import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/arguments/login_argument.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';

class FirstEditAccountPage extends ConsumerWidget {

  FirstEditAccountPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    LoginArguments arguments = ModalRoute.of(context)!.settings.arguments as LoginArguments;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'ユーザー名',
                  style: TextStyle(fontSize: 50),
                ),
                Container(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0,right: 50.0),
                  child: TextField(
                    controller: _userNameController,
                  ),
                ),
                Container(
                  height: 50,
                ),
                OutlinedButton(
                    onPressed: () async {
                      // arguments.uid
                      await ref.read(accountNotifierProvider.notifier).post(uid: arguments.uid, userName: _userNameController.text);
                      Navigator.pushNamed(
                        context,
                        SaunaPage.TAB.screenName,
                      );
                    },
                    child: const Text('決定')
                ),
              ],
            ),
          )
      ),
    );
  }
}