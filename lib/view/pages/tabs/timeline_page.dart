import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';

class TimeLinePage extends StatelessWidget {

  TimeLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text ('タイムライン'),
            automaticallyImplyLeading: false,
          ),
          endDrawer: const CustomDrawer(),
          body:
          ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Visibility(
                      visible: index != 0,
                      child: const Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('yyyy年　M月　D日　12：00'),
                                IconButton(
                                  onPressed: () {},
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.more_horiz,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.sentiment_very_satisfied,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('Good'),
                                )
                              ],
                            ),
                            Text('施設名 サウナ北欧'),
                            Container(
                              height: 200,
                              child: ListView.builder( scrollDirection: Axis.horizontal,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Container(
                                      height: 200,width: 200,
                                      child: Image.network('https://contents.oricon.co.jp/upimg/news/20190108/2126907_201901080813537001546926028c.jpg')
                                );
                              }
                              ),
                            ),
                          ],
                        ),
                        height: 300,
                        color: Colors.white
                    ),
                  ],
                );
              },
            ),
      ),
    );
  }
}