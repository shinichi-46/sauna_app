import 'package:flutter/material.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/pages/post/create_post_page.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {

  late DateTime _focused;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _focused = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          endDrawer: const CustomDrawer(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CreatePostPage(selectedDate: _selected ?? DateTime.now());
                  },
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'カレンダー',
                  style: TextStyle(fontSize: 30),
                ),
                Center(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2022, 4, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selected, day);
                    },
                    onDaySelected: (selected, focused) {
                      if (!isSameDay(_selected, selected)) {
                        setState(() {
                          _selected = selected;
                          _focused = focused;
                        });
                      }
                    },
                    focusedDay: _focused,

                  ),
                ),
                /*
                const Text(
                  'CalenderPage',
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
                        SaunaPage.CREATE_POST.screenName,
                      );
                    },
                    child: const Text('サウナ記録の登録画面に遷移する')
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
                 */
              Container(
                height: 330,
                child: ListView.builder(
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
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          SaunaPage.UPDATE_POST.screenName,
                                        );
                                      },
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
                              Text('施設名 サウナ北欧')
                            ],
                          ),
                          height: 100,
                          color: Colors.white
                        ),
                      ],
                    );
                  },
                ),
              ),
              ],
            ),
          )
      ),
    );
  }
}

List<Color> colorList = [Colors.cyan, Colors.deepOrange, Colors.indigo];

