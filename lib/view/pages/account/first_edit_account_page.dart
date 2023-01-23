import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';

class FirstEditAccountPage extends StatelessWidget {

  FirstEditAccountPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
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