import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';

class CreatePostPage extends StatelessWidget {

  CreatePostPage({Key? key}) : super(key: key);

  final _userNameController = TextEditingController();

  bool _flag = false;

  void _handleCheckbox(bool? e) {

  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text(
                      '記録',
                      style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                    height: 1,
                    thickness: 0.2,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.black,
                  ),
                Container(
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,),
                        child: Text(
                          '日時',
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10,),
                        child: Text(
                          'yyyy年/M月/D日',
                          style: TextStyle(fontSize: 15,)
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                      '評価',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10, right: 30, bottom: 10, left: 30),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, right:  70, bottom: 10, left: 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.grey,
                              size: 70,
                            ),
                            Text(
                                '良い'
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 70, bottom: 10, left: 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.sentiment_neutral,
                              color: Colors.grey,
                              size: 70,
                            ),
                            Text(
                                '普通'
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, right: 0, bottom: 10, left: 0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.grey,
                              size: 70,
                            ),
                            Text(
                                '悪い'
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        '施設名',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        width: 330,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'サウナの施設名を入力',
                          ),
                          controller: _userNameController,
                        ),
                      ),
                    ),
                    Text(
                        '選択',
                      style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),)
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: _flag,
                      onChanged: _handleCheckbox,// チェックボックスをタップした際のイベントハンドラ
                    ),
                    Text('お気に入りに追加'),
                  ],
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'メモ',
                    style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    '写真',
                    style: TextStyle(
                      fontSize: 20,fontWeight: FontWeight.bold,
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.collections,
                        size: 30,
                        color: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          '写真を選択',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                          ),),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.2,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Center(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          SaunaPage.TAB.screenName,
                        );
                      },
                      child: const Text('記録する')
                  ),
                ),
              ],
            ),
      ),
    );
  }
}