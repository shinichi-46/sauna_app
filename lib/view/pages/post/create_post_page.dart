import 'package:flutter/material.dart';

class CreatePostPage extends StatelessWidget {

  const CreatePostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(

          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'CreatePostPage',
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