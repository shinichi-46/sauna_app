import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';

class FirstEditAccountPage extends StatelessWidget {

  const FirstEditAccountPage({Key? key}) : super(key: key);

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
                  'FirstEditAccountPage',
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  'ごきげんよう！',
                  style: TextStyle(fontSize: 20),
                ),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SaunaPage.TAB.screenName,
                      );
                    },
                    child: const Text('TAB画面に遷移する')
                ),
              ],
            ),
          )
      ),
    );
  }
}