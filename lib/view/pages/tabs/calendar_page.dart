import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sauna_app/const/sauna_page_const.dart';
import 'package:sauna_app/view/pages/post/create_post_page.dart';
import 'package:sauna_app/view/widgets/custom_drawer_widget.dart';
import 'package:sauna_app/viewmodel/base/account_state_notifier.dart';
import 'package:sauna_app/viewmodel/base/post_state_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends ConsumerStatefulWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends ConsumerState<CalenderPage> {

  late DateTime _focused;
  DateTime? _selected;

  @override
  void initState() {
    super.initState();
    _focused = DateTime.now();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        endDrawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return CreatePostPage(selectedDate: _selected ?? DateTime.now());
                },
              ),
            );
            await ref.read(postNotifierProvider.notifier).fetch(
                creatorId: ref.watch(accountNotifierProvider).id,
                visitedDate: _selected
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
                  locale: 'ja_JP',
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  firstDay: DateTime.utc(2022, 4, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selected, day);
                  },
                  onDaySelected: (selected, focused) async {
                    if (!isSameDay(_selected, selected)) {
                      setState(() {
                        _selected = selected;
                        _focused = focused;
                      });
                    }
                    await ref.read(postNotifierProvider.notifier).fetch(
                        creatorId: ref.watch(accountNotifierProvider).id,
                        visitedDate: _selected
                    );
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
                itemCount: ref.watch(postNotifierProvider).length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Visibility(
                        visible: index != 0,
                        child: const Divider(
                          height: 1,
                          thickness: 0.2,
                          indent: 0,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${ref.watch(postNotifierProvider)[index].createdDate.year}/${ref.watch(postNotifierProvider)[index].createdDate.month}/${ref.watch(postNotifierProvider)[index].createdDate.day}　${ref.watch(postNotifierProvider)[index].createdDate.hour}：${ref.watch(postNotifierProvider)[index].createdDate.minute}',),
                                IconButton(
                                  onPressed: () {},
                                  constraints: const BoxConstraints(),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            Text(ref.watch(postNotifierProvider)[index].creatorName),
                            evaluationWidget(ref.watch(postNotifierProvider)[index].evaluationStatus                                                    ),
                            Text(ref.watch(postNotifierProvider)[index].placeName),
                            Visibility(
                              visible: ref.watch(postNotifierProvider)[index].imagePathList!.isNotEmpty,
                              child: Container(
                                height: 200,
                                child: ListView.builder( scrollDirection: Axis.horizontal,
                                    itemCount: ref.watch(postNotifierProvider)[index].imagePathList!.length,
                                    itemBuilder: (context, i) {
                                      return GestureDetector(
                                        onTap: () {
                                          showGeneralDialog(
                                            transitionDuration: Duration(milliseconds: 1000),
                                            barrierDismissible: true,
                                            barrierLabel: '',
                                            context: context,
                                            pageBuilder: (context, animation1, animation2) {
                                              return DefaultTextStyle(
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText1!,
                                                child: Center(
                                                  child: Container(
                                                    child: SingleChildScrollView(
                                                        child: InteractiveViewer(
                                                          minScale: 0.1,
                                                          maxScale: 5,
                                                          child: Container(
                                                            child: Image.network(ref.watch(postNotifierProvider)[index].imagePathList![i]
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                            height: 200,width: 200,
                                            child: Image.network(ref.watch(postNotifierProvider)[index].imagePathList![i], fit: BoxFit.fill,)
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ],
          ),
        )
    );
  }
  Widget evaluationWidget(int evaluationStatus) {//evaluationWidgetは自分で決めた名前で良い。データ型、関数名、引数の形で表す。
    switch(evaluationStatus){
      case 0:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_very_satisfied,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('良い'),
            )
          ],
        );
      case 1:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_neutral,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('普通'),
            )
          ],
        );
      case 2:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('悪い'),
            )
          ],
        );
      default:
        return  Row(
          children: [
            Icon(
              Icons.sentiment_neutral,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('普通'),
            )
          ],
        );
    }
  }
}

List<Color> colorList = [Colors.cyan, Colors.deepOrange, Colors.indigo];

