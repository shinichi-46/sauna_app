import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';

class TimeLinePage extends StatelessWidget {

  const TimeLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          endDrawer: const CustomDrawer(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'TimeLinePage',
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
                        SaunaPage.UPDATE_POST.screenName,
                      );
                    },
                    child: const Text('サウナ記録の更新画面に遷移する')
                ),
              ],
            ),
          )
      ),
    );
  }
}