import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/arguments/login_argument.dart';

class FirstEditAccountPage extends StatelessWidget {

  FirstEditAccountPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      try {
                        final CollectionReference collection = FirebaseFirestore.instance.collection('user');
                        await collection.doc(arguments.uid).set({
                          'id': arguments.uid,
                          'user_name': _userNameController.text,
                          'favorite_place_list':null,
                          'icon_image_path':null,
                        });
                      } catch (err) {
                        print('error');
                      }
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