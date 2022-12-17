import 'package:flutter/material.dart';

class AgainEditAccountPage extends StatelessWidget {

  const AgainEditAccountPage({Key? key}) : super(key: key);

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
                  'AgainEditAccountPage',
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  'ごきげんよう！',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )
      ),
    );
  }
}